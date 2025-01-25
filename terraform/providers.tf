terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.9"
    }
  }

  required_version = ">= 1.0"
}

provider "kubernetes" {
  config_path = "~/.kube/config"  # Path to your kubeconfig file
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}