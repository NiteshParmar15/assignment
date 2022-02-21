variable "cidr" {
  description = "Enter the CIDR range required for VPC"
  type        = string
  default     = "192.168.0.0/16"
}
variable "enable_dns_hostnames" {
  description = "Enable DNS Hostname"
  type        = bool
  default     = null
}
variable "enable_dns_support" {
  description = "Enable DNS Support"
  type        = bool
  default     = null
}
variable "vpc_name" {
  description = "Tag Name to be assigned with VPC"
  type        = string
}
variable "igw_tag" {
  description = "Mention Tag needs to be associated with internet gateway"
  type        = string
  default     = "igw"
}
variable "public_subnets_cidr" {
  description = "Cidr Blocks"
  type        = string
  default     = "192.168.1.0/24"
}
variable "private_subnets_cidr" {
  description = "Cidr Blocks"
  type        = string
  default     = "192.168.2.0/24"
}
variable "public_subnet_tag" {
  description = "Tag for public subnet"
  type        = string
  default     = "torum_public_subnet"
}
variable "private_subnet_tag" {
  description = "Tag for private subnet"
  type        = string
  default     = "torum_private_subnet"
}
variable "public_route_table_tag" {
  description = "Tag name for public route table"
  type        = string
  default     = "torum_public_route_table"
}
variable "private_route_table_tag" {
  description = "Tag name for public route table"
  type        = string
  default     = "torum_private_route_table"
}

variable "default_security_group_name" {
  description = "Enter the name for security group"
  type        = string
  default     = null
}

variable "enable_dhcp_options" {
  description = "Enable DHCP options.. True or False"
  type        = bool
  default     = null
}

variable "manage_default_route_table" {
  description = "Are we managing default route table"
  type        = bool
  default     = null
}


variable "public_subnet" {
  description = "enter the number of public subnets you need"
  type        = number
  default     = null
}
variable "security_group" {
  description = "Tag for security group"
  type        = string
}
variable "map_public_ip_on_launch" {
  description = "It will map the public ip while launching resources"
  type        = bool
  default     = null
}
