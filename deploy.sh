#!/bin/bash


# Install aws cli

sudo apt-get install unzip -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Install Kubectl
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
sudo apt-get update
sudo apt-get install -y kubectl


# Initialize Terraform
terraform init

# Apply Terraform Configuration (Creates EKS Cluster and Kubernetes Resources)
terraform apply -auto-approve

# # Retrieve EKS Cluster Name and Region from Terraform Output
EKS_CLUSTER_NAME=$(terraform output eks_cluster_name)
AWS_REGION=$(terraform output aws_region)

# # Configure kubectl with AWS CLI
aws eks --region $AWS_REGION update-kubeconfig --name $EKS_CLUSTER_NAME

# Apply Kubernetes Manifests (Deployment, Service, etc.)
kubectl apply -f deployment.yml
kubectl apply -f service.yml
