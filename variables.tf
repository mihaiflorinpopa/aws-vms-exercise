variable "env" {
  description = "Environment"
  type        = string
}

variable "region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "us-east-1"
}

variable "profile" {
  description = "AWS CLI profile"
  type        = string
  default     = ""
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
}

variable "subnet_cidr_block" {
  description = "CIDR block for subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone where resources to be created"
  type        = string
}

variable "map_public_ip_on_launch" {
  description = "Map public IP for subnet"
  type        = string
  default     = true
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 2
}

variable "ami" {
  description = "AMI ID for the instances"
  type        = string
  default     = "ami-06f59e43b31a49ecc"
}

variable "project" {
  description = "Name of the project"
  type        = string
}

variable "user" {
  description = "OS user"
  type        = string
  default     = "ubuntu"
}