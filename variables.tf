variable "aws_region" {
  description = "The AWS Region"
  type        = string
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR value"
}

variable "public_subnets_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR values"
}

variable "private_subnets_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values"
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
}
