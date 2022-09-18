# Locals Block for custom data
locals {
  webvm_custom_data = <<CUSTOM_DATA
#!/bin/bash

# cd to home for easier write access
cd home/${var.web_linuxvm_username}/

# clone web api repo
git clone ${var.web_linuxvm_api_repo_url}

cd DatingApp-API
git checkout production-migrations

# msft package signing keys
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

# update package repo list and install dotnet core 3.1
sudo apt-get update; \
  sudo apt-get install -y apt-transport-https && \
  sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-3.1

# configure apache
sudo apt install apache2 -y
sudo a2enmod proxy proxy_http proxy_html
sudo systemctl restart apache2

# virtual host and enable site
sudo echo "
<VirtualHost *:80>
ProxyPreserveHost On
ProxyPass / http://127.0.0.1:5000/
ProxyPassReverse / http://127.0.0.1:5000/

ErrorLog /var/log/apache2/datingapp-error.log
CustomLog /var/log/apache2/datingapp-access.log common

</VirtualHost>
" > /etc/apache2/sites-available/datingapp.conf

sudo a2ensite datingapp
sudo systemctl reload apache2

sudo apt-get install jq -y

# set env vars for use when updating env file
export token=${var.web_linuxvm_app_token}
export cloud_name=${var.web_linuxvm_app_cloudinary_name}
export api_key=${var.web_linuxvm_app_cloudinary_api_key}
export api_secret=${var.web_linuxvm_app_cloudinary_api_secret}
export key_vault_name=${local.key_vault_name}
export mysql_conn_string=${azurerm_key_vault_secret.mysql_conn_string.name}

# update appsettings.json file in-place
cp appsettings.example.json appsettings.json
sudo chmod 777 appsettings.json
cat <<< "$(jq --arg token "$token" '.AppSettings.Token = $token' appsettings.json)" > appsettings.json
cat <<< "$(jq --arg cloud_name "$cloud_name" '.CloudinarySettings.CloudName = $cloud_name' appsettings.json)" > appsettings.json
cat <<< "$(jq --arg api_key "$api_key" '.CloudinarySettings.ApiKey = $api_key' appsettings.json)" > appsettings.json
cat <<< "$(jq --arg api_secret "$api_secret" '.CloudinarySettings.ApiSecret = $api_secret' appsettings.json)" > appsettings.json
# cat <<< "$(jq --arg db_connection_string "$db_connection_string" '.ConnectionStrings.DefaultConnection = $db_connection_string' appsettings.json)" > appsettings.json

cat <<< "$(jq --arg key_vault_name "$key_vault_name" '.KeyVaultName = $key_vault_name' appsettings.json)" > appsettings.json
cat <<< "$(jq --arg mysql_conn_string "$mysql_conn_string" '.MySqlConnectionStringVaultKey = $mysql_conn_string' appsettings.json)" > appsettings.json

# restore and build app, publish w/ sudo to allow write access to /var
dotnet restore
dotnet build
sudo dotnet publish -c Release -o /var/datingapp

# configure kestrel service
sudo sh -c "echo '
[Unit]
Description=Kestrel service running on Ubuntu 20.04
[Service]
WorkingDirectory=/var/datingapp
ExecStart=/usr/bin/dotnet /var/datingapp/DatingApp.API.dll
Restart=always
RestartSec=10
SyslogIdentifier=datingapp
User=www-data
Environment=ASPNETCORE_ENVIRONMENT=Production
[Install]
WantedBy=multi-user.target
' >> /etc/systemd/system/kestrel-web.service"

sudo systemctl enable kestrel-web.service
sudo systemctl start kestrel-web.service

sudo apt-get install net-tools -y

sudo a2dissite 000-default.conf
sudo service apache2 reload
CUSTOM_DATA
}

# Resource: Azure Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "web_linuxvm" {
  name                  = local.web_linuxvm_name
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  size                  = var.web_linuxvm_sku
  admin_username        = var.web_linuxvm_username
  network_interface_ids = [azurerm_network_interface.web_linuxvm_nic.id]
  admin_ssh_key {
    username   = var.web_linuxvm_username
    public_key = file("${path.module}/ssh-keys/terraform-azure.pem.pub")
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.web_linuxvm_osdisk_storage_type
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  custom_data = base64encode(local.webvm_custom_data)
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.uai.id]
  }
}
