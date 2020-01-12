locals {
  tiller_namespace = "kube-system"
}

data "google_client_config" "default" {
} 





# Create a ServiceAccount for Tiller
resource "kubernetes_service_account" "tiller" {
  metadata {
    name      = "tiller"
    namespace = local.tiller_namespace
  }
}

# Create a role binding for Tiller, use same name as tiller to resolve helm provider dependency issue
resource "kubernetes_cluster_role_binding" "tiller" {
  metadata {
    name = kubernetes_service_account.tiller.metadata.0.name
  }
  role_ref {
    kind      = "ClusterRole"
    name      = "cluster-admin"
    api_group = "rbac.authorization.k8s.io"
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.tiller.metadata[0].name
    namespace = local.tiller_namespace
  }
}

#helm provider to deploy nginx ingress. depend on both SA creation and role binding
provider "helm" {
  kubernetes {
    host                   = "https://${var.endpoint}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(var.ca_certificate)
  }
  version        = "~> 0.9"
  install_tiller = true
  namespace       = kubernetes_service_account.tiller.metadata.0.namespace
  service_account = kubernetes_cluster_role_binding.tiller.metadata.0.name
  tiller_image    = "gcr.io/kubernetes-helm/tiller:v2.11.0"
}
