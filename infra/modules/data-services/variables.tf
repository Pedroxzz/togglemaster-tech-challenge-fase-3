variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr" {
  type    = string
  default = "10.30.0.0/16"
}

variable "subnet_ids" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}

variable "db_master_username" {
  type      = string
  default   = "togglemaster"
  sensitive = true
}

variable "db_master_password" {
  type      = string
  default   = "ToggleMaster123!"
  sensitive = true
}
