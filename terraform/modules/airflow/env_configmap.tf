resource "kubernetes_config_map" "airflow_env_vars" {
  metadata {
    name      = "airflow-env-vars"
    namespace = var.namespace
  }

  data = {
    MINIO_ENDPOINT       = var.minio_endpoint
    MINIO_ACCESS_KEY     = var.minio_access_key
    MINIO_SECRET_KEY     = var.minio_secret_key
    MINIO_BUCKET_RAW     = var.minio_bucket_raw
    MLFLOW_TRACKING_URI  = var.mlflow_tracking_uri
    MINIO_BUCKET_PROCESSED = var.minio_bucket_processed
    MLFLOW_EXPERIMENT_NAME = var.mlflow_experiment_name
  }
}