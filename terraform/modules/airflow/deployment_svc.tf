resource "kubernetes_service" "mlflow_model_service" {
  metadata {
    name      = "mlflow-model-service"
    namespace = "airflow"
  }

  spec {
    selector = {
      app = "mlflow-model-serving"
    }

    port {
      port        = 31080
      target_port = 5001
    }

    type = "ClusterIP"
  }
}