resource "kubernetes_job" "create_bucket" {
  metadata {
    name      = "create-minio-bucket"
    namespace = var.namespace
  }

  spec {
    template {
      metadata {
        labels = {
          app = "create-bucket"
        }
      }

      spec {
        restart_policy = "OnFailure"

        container {
          name  = "mc-create-bucket"
          image = "minio/mc:latest"

          command = [
            "sh",
            "-c",
            <<-EOT
              until mc alias set minio http://minio.${var.namespace}.svc.cluster.local:9000 $MINIO_ROOT_USER $MINIO_ROOT_PASSWORD; do
                echo "Waiting for MinIO...";
                sleep 5;
              done
              mc mb minio/mlflow-artifacts || true
            EOT
          ]

          env {
            name  = "MINIO_ROOT_USER"
            value = var.minio_root_user
          }

          env {
            name  = "MINIO_ROOT_PASSWORD"
            value = var.minio_root_password
          }
        }
      }
    }
  }

  depends_on = [
    kubernetes_deployment.minio,
    kubernetes_service.minio
  ]
}
