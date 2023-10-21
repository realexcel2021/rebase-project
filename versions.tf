terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.22.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.2.1"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.23.0"
    }
  }

  required_version = ">= 0.14"
}

