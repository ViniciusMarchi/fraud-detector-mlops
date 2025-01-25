# Role for namespace-specific permissions
resource "kubernetes_role" "airflow_worker_role" {
  metadata {
    name      = "airflow-worker-role"
    namespace = "airflow"
  }

  rule {
    api_groups = [""]
    resources  = ["pods", "pods/log"]
    verbs      = ["get", "list", "watch", "create", "delete"]
  }

  rule {
    api_groups = [""]
    resources  = ["configmaps"]
    verbs      = ["get", "list", "watch"]
  }
  rule {
    api_groups = ["apps"]         
    resources  = ["deployments"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }
  # Add permissions for managing services
  rule {
    api_groups = [""]
    resources  = ["services"]
    verbs      = ["get", "list", "watch", "create", "update", "delete"]
  }
}

# RoleBinding for namespace-specific permissions
resource "kubernetes_role_binding" "airflow_worker_rolebinding" {
  metadata {
    name      = "airflow-worker-rolebinding"
    namespace = "airflow"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.airflow_worker_role.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = "airflow-worker"
    namespace = "airflow"
  }
}