# Create namespaces
resource "kubernetes_namespace" "mlflow" {
  metadata {
    name = var.mlflow_namespace
  }
}

resource "kubernetes_namespace" "minio" {
  metadata {
    name = var.minio_namespace
  }
}

resource "kubernetes_namespace" "grafana" {
  metadata {
    name = var.grafana_namespace
  }
}

resource "kubernetes_namespace" "prometheus" {
  metadata {
    name = var.prometheus_namespace
  }
}

resource "kubernetes_namespace" "airflow" {
  metadata {
    name = var.airflow_namespace
  }
}

resource "kubernetes_namespace" "streamlit" {
  metadata {
    name = var.streamlit_namespace
  }
}

module "postgresql" {
  source = "./modules/postgresql"

  namespace       = kubernetes_namespace.mlflow.metadata[0].name
  postgres_db     = var.postgres_db
  postgres_user   = var.postgres_user
  postgres_password = var.postgres_password
}

module "minio" {
  source = "./modules/minio"

  namespace         = kubernetes_namespace.minio.metadata[0].name
  minio_root_user   = var.minio_root_user
  minio_root_password = var.minio_root_password
}

module "mlflow" {
  source = "./modules/mlflow"

  mlflow_image      = var.mlflow_image
  namespace         = kubernetes_namespace.mlflow.metadata[0].name
  postgres_host     = module.postgresql.postgres_host
  postgres_db       = var.postgres_db
  postgres_user     = var.postgres_user
  postgres_password = var.postgres_password
  minio_endpoint    = module.minio.minio_endpoint
  minio_root_user   = var.minio_root_user
  minio_root_password = var.minio_root_password
}

module "airflow" {
  source = "./modules/airflow"
  namespace = kubernetes_namespace.airflow.metadata[0].name
  minio_endpoint = var.minio_endpoint
  minio_access_key = var.minio_root_user
  minio_secret_key = var.minio_root_password
  minio_bucket_raw = var.minio_bucket_raw
  minio_bucket_processed = var.minio_bucket_processed
  mlflow_tracking_uri = var.mlflow_tracking_uri
  mlflow_experiment_name = var.mlflow_experiment_name
}

module "streamlit" {
  source              = "./modules/streamlit"
  namespace = kubernetes_namespace.streamlit.metadata[0].name
  image               = var.streamlit_image
  port                = 8501
  minio_endpoint = var.minio_endpoint
  minio_access_key = var.minio_root_user
  minio_secret_key = var.minio_root_password
  minio_bucket_raw = var.minio_bucket_raw
  minio_bucket_processed = var.minio_bucket_processed
  mlflow_deployment_serve_uri = var.mlflow_deployment_serve_uri
}


module "grafana" {
  source = "./modules/grafana"

  namespace = kubernetes_namespace.grafana.metadata[0].name
}

module "prometheus" {
  source = "./modules/prometheus"

  namespace = kubernetes_namespace.prometheus.metadata[0].name
}
