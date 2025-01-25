variable "namespace" {
  description = "Namespace for Airflow"
  type        = string
}

variable "minio_endpoint" {
  description = "MinIO service endpoint"
  type        = string
}

variable "minio_access_key" {
  description = "MinIO access key"
  type        = string
}

variable "minio_secret_key" {
  description = "MinIO secret key"
  type        = string
}

variable "minio_bucket_raw" {
  description = "MinIO raw bucket name"
  type        = string
}

variable "minio_bucket_processed" {
  description = "MinIO processed bucket name"
  type        = string
}

variable "mlflow_tracking_uri" {
  description = "MLflow tracking URI"
  type        = string
}

variable "mlflow_experiment_name" {
  description = "MLflow experiment name"
  type        = string
}