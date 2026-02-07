output "eks_dev_cluster_name" {
  value = module.eks_dev.cluster_name
}

output "eks_test_cluster_name" {
  value = module.eks_test.cluster_name
}

output "eks_prod_cluster_name" {
  value = module.eks_prod.cluster_name
}

output "argocd_server_url" {
  value = helm_release.argocd.status[0].load_balancer[0].ingress[0].hostname
}
