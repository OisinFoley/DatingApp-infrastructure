variable "mysql_server_name" {
  description = "Azure MySQL Database Server Name"
  type        = string
  default     = "mysql-server"
}

variable "mysql_db_username" {
  description = "Azure MySQL Database Administrator Username"
  type        = string
}

# DB Password - Enable Sensitive flag
variable "mysql_db_password" {
  description = "Azure MySQL Database Administrator Password"
  type        = string
  sensitive   = true
}

variable "mysql_db_schema" {
  description = "Azure MySQL Database Schema Name"
  type        = string
}
