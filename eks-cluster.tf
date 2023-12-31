locals {
  cluster_name = "test-eks-cluster-python-1"
}

data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}


module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 19.0"
  cluster_name    = local.cluster_name
  cluster_version = "1.27"
  subnet_ids         = module.vpc.private_subnets

  vpc_id = module.vpc.vpc_id
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access = true
  create_kms_key = true
  kms_key_owners = [ data.aws_caller_identity.current.arn ]

  
  iam_role_additional_policies = {
    EKSClusterAutoScalerPolicy      = aws_iam_policy.cluster_autoscaler_policy_for_eks.arn
    EKSNodegroupClusterIssuerPolicy = aws_iam_policy.eks_nodegroup_cluster_issuer_policy.arn
    EKSNodegroupExternalDNSPolicy   = aws_iam_policy.eks_nodegroup_exteral_dns_policy.arn
  }

  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    instance_types = ["m5.large"]
    

    iam_role_additional_policies = {
      EKSClusterAutoScalerPolicy      = aws_iam_policy.cluster_autoscaler_policy_for_eks.arn
      EKSNodegroupClusterIssuerPolicy = aws_iam_policy.eks_nodegroup_cluster_issuer_policy.arn
      EKSNodegroupExternalDNSPolicy   = aws_iam_policy.eks_nodegroup_exteral_dns_policy.arn
    }
  }

  eks_managed_node_groups = {
    python-app-ng = {
      min_size     = 1
      max_size     = 2
      desired_size = 1

      instance_types = ["t3.large"]
      capacity_type  = "SPOT"


      update_config = {
        max_unavailable_percentage = 33 # or set `max_unavailable`
      }
    }
  }


  cluster_addons = {
  coredns = {
    most_recent = true
  }
  kube-proxy = {
    most_recent = true
  }
  vpc-cni = {
    most_recent = true
  }
}


}