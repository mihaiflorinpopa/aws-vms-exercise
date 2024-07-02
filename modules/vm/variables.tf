variable "ami" {
  description = "AMI ID for the instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "VPC security group IDs"
  type        = list(string)
}

variable "associate_public_ip_address" {
  description = "Associate public IP"
  type        = string
  default     = true
}

variable "name" {
  description = "Name tag for the instance"
  type        = string
}

variable "user_data" {
  description = "The user data script to use for the instance."
  type        = string
}

variable "admin_password" {
  description = "The admin password for the instance."
  type        = string
}

variable "env" {
  description = "Environment"
  type        = string
}