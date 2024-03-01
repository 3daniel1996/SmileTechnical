terraform {
  source = "../../../infrastructure"
}
locals {
  project     = "smile"
  environment = reverse(split("/", get_terragrunt_dir()))[0]
}

generate "remote_state" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "s3" {
    bucket         = "terraform-remote-state-${local.project}-${local.environment}"
    key            = "${local.project}/${local.environment}/hellosmile.tfstate"
    dynamodb_table = "terraform-remote-state-lock-${local.project}"
    region         = "us-east-1"
    encrypt        = true
  }
}
EOF
}

generate "tfvars" {
  path              = "terragrunt.auto.tfvars"
  if_exists         = "overwrite"
  disable_signature = true
  contents          = <<-EOF
EOF
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "aws" {
  region  = var.aws_region
  default_tags {
    tags = {
      "Created By"    = "Daniel Smith"
      "Project"       = "HelloSmile"
      "Environment"   = "${local.environment}"
    }
  }
}
data "aws_eks_cluster_auth" "cluster_auth" {
  name = module.eks.cluster_endpoint
}
provider "helm" {
  kubernetes {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", "smile"]
      command     = "aws"
    }
  }
}
EOF
}