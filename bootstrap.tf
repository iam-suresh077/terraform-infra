resource "kubernetes_manifest" "gitops_root" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"

    metadata = {
      name      = "gitops-root"
      namespace = "argocd"
    }

    spec = {
      source = {
        repoURL        = "https://github.com/your-org/gitops-repo"
        targetRevision = "main"
        path           = "applications"
      }

      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = "argocd"
      }

      syncPolicy = {
        automated = {
          prune    = true
          selfHeal = true
        }
      }
    }
  }

  depends_on = [helm_release.argocd]
}
