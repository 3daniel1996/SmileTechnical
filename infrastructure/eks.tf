module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name                    = var.shared_resource_name
  cluster_version                 = var.cluster_version
  vpc_id                          = module.vpc.vpc_id
  subnet_ids                      = module.vpc.private_subnets
  create_cloudwatch_log_group     = false
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
  enable_irsa                     = true
  tags                            = var.tags
  create_kms_key                  = true


  cluster_addons = {
    vpc-cni    = {}
    coredns    = {}
    kube-proxy = {}
  }

  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "WAS: Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      cidr_blocks = ["192.168.0.0/16"]
    }
    egress_all = {
      description      = "WAS: Node all egress"
      protocol         = "-1"
      from_port        = 0
      to_port          = 0
      type             = "egress"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }

  eks_managed_node_groups = {
    eks = {
      name              = "${var.shared_resource_name}-worker-nodes"
      capacity_type     = var.capacity_type
      enable_monitoring = false
      desired_size      = var.desired_worker_node
      max_size          = var.max_worker_node
      min_size          = var.min_worker_node
      disk_size         = var.disk_size
      instance_types    = var.instance_types

      labels = {
        node-group = var.namespace
      }

    }
  }

  iam_role_additional_policies = {
    WorkersAdditionalPolicies = aws_iam_policy.worker_policy.arn
  }

}

#------------------------------------------------------------------------------
#                             SUPPORTING RESOURCES
#------------------------------------------------------------------------------

resource "aws_iam_policy" "worker_policy" {
  name        = "node-workers-policy-${var.shared_resource_name}"
  description = "Node Workers IAM policies"

  policy = file("${path.module}/node-workers-policy.json")
}
