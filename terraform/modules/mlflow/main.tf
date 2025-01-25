resource "kubernetes_deployment" "mlflow" {
  metadata {
    name      = "mlflow"
    namespace = var.namespace
    labels = {
      app = "mlflow"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "mlflow"
      }
    }

    template {
      metadata {
        labels = {
          app = "mlflow"
        }
      }

      spec {
        container {
          name  = "mlflow"
          image = var.mlflow_image
          image_pull_policy = "IfNotPresent"
          command = ["mlflow"]
          args = ["server", "--host", "0.0.0.0", 
            "--port", "5000", 
            "--backend-store-uri", "postgresql://${var.postgres_user}:${var.postgres_password}@${var.postgres_host}:5432/${var.postgres_db}", 
            "--serve-artifacts",
            "--artifacts-destination", "s3://mlflow-artifacts"
          ]



          env {
            name  = "MLFLOW_S3_ENDPOINT_URL"
            value = var.minio_endpoint
          }

          env {
            name  = "AWS_ACCESS_KEY_ID"
            value = var.minio_root_user
          }

          env {
            name  = "AWS_SECRET_ACCESS_KEY"
            value = var.minio_root_password
          }

          port {
            container_port = 5000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "mlflow" {
  metadata {
    name      = "mlflow"
    namespace = var.namespace
  }

  spec {
    selector = {
      app = "mlflow"
    }

    port {
      port        = 80
      target_port = 5000
      node_port   = 30080
    }

    type = "NodePort"
  }
}