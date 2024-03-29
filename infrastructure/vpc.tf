data "aws_availability_zones" "available" {
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name                 = var.shared_resource_name
  cidr                 = var.cidr
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = var.private_subnets
  public_subnets       = var.public_subnets
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_ipv6          = false
  enable_dns_support   = true

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.shared_resource_name}" = "owned"
    "karpenter.sh/discovery"                            = var.shared_resource_name
    "kubernetes.io/role/internal-elb"                   = "1"
  }
  public_subnet_tags = {
    "kubernetes.io/cluster/${var.shared_resource_name}" = "shared"
    "kubernetes.io/role/elb"                            = "1"
  }
}