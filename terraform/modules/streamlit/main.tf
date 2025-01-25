resource "kubernetes_deployment" "streamlit" {
  metadata {
    name      = "streamlit"
    namespace = var.namespace
    labels = {
      app = "streamlit"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "streamlit"
      }
    }

    template {
      metadata {
        labels = {
          app = "streamlit"
        }
      }

      spec {
        container {
          name  = "streamlit"
          image = var.image
          image_pull_policy = "IfNotPresent"

          port {
            container_port = var.port
          }

          env {
            name  = "MLFLOW_SERVE_DEPLOYMENT_URI"
            value = var.mlflow_deployment_serve_uri
          }

          env {
            name  = "MINIO_ENDPOINT"
            value = var.minio_endpoint
          }

          env {
            name  = "MINIO_ACCESS_KEY"
            value = var.minio_access_key
          }

          env {
            name  = "MINIO_SECRET_KEY"
            value = var.minio_secret_key
          }


          env {
            name  = "MINIO_BUCKET_RAW"
            value = var.minio_bucket_raw
          }

          env {
            name  = "MINIO_BUCKET_PROCESSED"
            value = var.minio_bucket_processed
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "streamlit" {
  metadata {
    name      = "streamlit"
    namespace = var.namespace
    labels = {
      app = "streamlit"
    }
  }

  spec {
    selector = {
      app = "streamlit"
    }

    port {
      port        = var.port
      target_port = var.port
      node_port   = 30007
    }

    type = "NodePort"
  }
}