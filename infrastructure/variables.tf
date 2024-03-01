###############################################################################
# General AWS Deployment Options
###############################################################################
variable "aws_region" {
  description = "A region code describing the location of the physical AWS data center in which all resources will be deployed."
  default     = "us-east-1"
  type        = string
}


variable "shared_resource_name" {
  description = "A short string value to identify the subdomain of your HelloSmile"
  default     = "smile"
  type        = string
}

###############################################################################
# AWS Virtual Private Network Options
###############################################################################
variable "cidr" {
  description = "The subnet pattern to be used for all Terraform-managed resources requiring network configuration."
  type        = string
  default     = "192.168.0.0/20"
}

variable "private_subnets" {
  description = "The CIDR's of the two internal subnetworks that Terraform with automatically create for you."
  type        = list(string)
  default     = ["192.168.4.0/24", "192.168.5.0/24"]
}
variable "public_subnets" {
  description = "the CIDRs of the two public subnets that Terraform will automatically create for you."
  type        = list(string)
  default     = ["192.168.1.0/24", "192.168.2.0/24"]
}



###############################################################################
# AWS EKS variables
###############################################################################
variable "usernameArn" {
  description = "User Arn you will be running the manifest scripts"
  type        = string
}

variable "cluster_version" {
  description = "The version of Kubernetes for your AWS EKS Kubernetes cluster"
  default     = "1.29"
  type        = string
}

variable "namespace" {
  default = "smile"
  type    = string
}

variable "disk_size" {
  description = "The number of gigabytes of storages to allocate to each Linux server node supporting your Kubernetes cluster"
  default     = "30"
  type        = number
}

variable "instance_types" {
  description = "the range of AWS EC2 instance types that Kubernetes will attempt to acquire from the AWS EC2 spot market"
  type        = list(string)
  default     = ["t3.2xlarge", "t3a.2xlarge", "t2.2xlarge"]
}

variable "desired_worker_node" {
  description = "The number of AWS EC2 Linux worker instances to create and assigned to your Kubernetes cluster"
  default     = "2"
  type        = number
}

variable "min_worker_node" {
  description = "The minimum permitted number of AWS EC2 Linux worker instances to be assigned to your Kubernetes cluster"
  default     = "2"
  type        = number
}

variable "max_worker_node" {
  description = "The maximum permitted number of AWS EC2 Linux worker instances to be assigned to your Kubernetes cluster when scaling"
  default     = "10"
  type        = number
}

variable "capacity_type" {
  description = "Pricing scheme to be used by AWS EC2 when acquiring Linux server instances for your cluster. Valid options are: ON_DEMAND, SPOT, RESERVED"
  default     = "SPOT"
  type        = string
}