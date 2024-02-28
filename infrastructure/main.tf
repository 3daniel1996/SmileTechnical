locals {
  name        = "eks-ref-arch-eks-mng"
  region      = "us-east-1"
  environment = "nonprod"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)
}