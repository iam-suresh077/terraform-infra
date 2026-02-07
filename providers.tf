terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.25"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12"
    }
  }
}

provider "aws" {
  region = var.region
}


data "aws_eks_cluster_auth" "dev" {
  name = module.eks_dev.cluster_name
}

provider "kubernetes" {
  host                   = module.eks_dev.cluster_endpoint
  cluster_ca_certificate = base64decode(
    module.eks_dev.cluster_certificate_authority_data
  )
  token = data.aws_eks_cluster_auth.dev.token
}

provider "helm" {
  kubernetes {
    host                   = module.eks_dev.cluster_endpoint
    cluster_ca_certificate = base64decode(
      module.eks_dev.cluster_certificate_authority_data
    )
    token = data.aws_eks_cluster_auth.dev.token
  }
}

