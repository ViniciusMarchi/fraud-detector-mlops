resource "kubernetes_deployment" "minio" {
  metadata {
    name      = "minio"
    namespace = var.namespace
    labels = {
      app = "minio"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "minio"
      }
    }

    template {
      metadata {
        labels = {
          app = "minio"
        }
      }

      spec {
        container {
          name  = "minio"
          image = "minio/minio:latest"

          args = ["server", "/data", "--console-address", ":9001", "--address", ":9000"]

          env {
            name  = "MINIO_ROOT_USER"
            value = var.minio_root_user
          }

          env {
            name  = "MINIO_ROOT_PASSWORD"
            value = var.minio_root_password
          }

          port {
            container_port = 9000
          }

          port {
            container_port = 9001
          }
          readiness_probe {
            http_get {
              path = "/minio/health/ready"
              port = 9000
            }
            initial_delay_seconds = 10
            period_seconds         = 5
          }
          
          volume_mount {
            name       = "minio-data"
            mount_path = "/data"
          }
        }

        volume {
          name = "minio-data"
          empty_dir {}
        }
      }
    }
  }
}

resource "kubernetes_service" "minio" {
  metadata {
    name      = "minio"
    namespace = var.namespace
  }

  spec {
    selector = {
      app = "minio"
    }

    port {
      name        = "api"
      port        = 9000
      target_port = 9000
      node_port   = 30090
    }

    port {
      name        = "ui"
      port        = 9001
      target_port = 9001
      node_port   = 30091
    }

    type = "NodePort"
  }
}

output "minio_endpoint" {
  value = "http://minio.${var.namespace}.svc.cluster.local:9000"
}