resource "kubernetes_config_map" "mlflow_deployment_manifest" {
  metadata {
    name      = "mlflow-deployment-yaml"
    namespace = "airflow"
  }

  data = {
    "mlflow-deployment.yaml" = file("${path.module}/../../manifests/model-deployment.yaml")
  }
}
