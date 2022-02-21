variable "ami_id" {
  type    = string
  default = "ami-04505e74c0741db8d"
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "associate_public_ip" {
  type    = bool
}
variable "security_group_id" {
  type    = string
}
variable "private_subnet_id" {
  type    = string
}

variable "disable_api_termination" {
  type    = bool
  default = false
}
variable "instance_profile" {
  type    = string
  default = "ec2"
}

variable "key_name" {
  type    = string
  default = null
}
variable "volume_size" {
  type    = number
  default = 10
}
variable "ec2_tag" {
  description = "Ec2 tag"
  type        = list(string)
  default     = ["prod-web-server-1","prod-web-server-2"]
}
