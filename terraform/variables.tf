variable "aws_region" {
  description = "Região AWS da infraestrutura."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nome base do projeto."
  type        = string
  default     = "togglemaster"
}

variable "environment" {
  description = "Ambiente da infraestrutura."
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  type    = string
  default = "10.30.0.0/16"
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.30.1.0/24", "10.30.2.0/24"]
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.30.11.0/24", "10.30.12.0/24"]
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "eks_cluster_version" {
  type    = string
  default = "1.30"
}

variable "eks_node_instance_type" {
  type    = string
  default = "t3.medium"
}

variable "eks_node_desired_size" {
  type    = number
  default = 2
}

variable "eks_node_max_size" {
  type    = number
  default = 3
}

variable "eks_node_min_size" {
  type    = number
  default = 1
}

variable "db_master_username" {
  type    = string
  default = "togglemaster"
}

variable "db_master_password" {
  type      = string
  default   = "ChangeThisPassword123!"
  sensitive = true
}
