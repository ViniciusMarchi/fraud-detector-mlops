resource "helm_release" "airflow" {
  name             = "airflow"
  chart            = "airflow"
  repository       = "https://airflow.apache.org"
  namespace        = var.namespace
  create_namespace = false
  values           = [file("${path.module}/values.yaml")]
  
  wait             = false
  force_update     = true
  recreate_pods    = true
}
