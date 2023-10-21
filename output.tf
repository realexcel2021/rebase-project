data "aws_region" "current" {
  
}

output "aws_region" {
  value = data.aws_region.current
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "ecr-image" {
  value = aws_ecr_repository.foo.repository_url
}