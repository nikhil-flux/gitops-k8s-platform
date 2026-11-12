variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Prefix for resource names"
  type        = string
  default     = "gitops-k8s"
}

variable "instance_type" {
  description = "EC2 instance type. t3.small (2GB) is the practical minimum for k3s + Argo CD + monitoring."
  type        = string
  default     = "t3.small"
}

variable "key_name" {
  description = "Name of an existing EC2 key pair for SSH"
  type        = string
}

variable "my_ip_cidr" {
  description = "Your public IP in CIDR form, e.g. 203.0.113.7/32. Never use 0.0.0.0/0."
  type        = string
}
