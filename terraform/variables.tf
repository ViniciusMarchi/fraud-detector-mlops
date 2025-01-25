# --------------------------
# MINIO
# --------------------------
variable "minio_endpoint" {
  description = "MinIO service endpoint"
  type        = string
  default     = "minio.minio.svc.cluster.local:9000"
}

variable "minio_namespace" {
  description = "Namespace for MinIO"
  default     = "minio"
}

variable "minio_root_user" {
  description = "MinIO root user"
  default     = "minio"
}

variable "minio_root_password" {
  description = "MinIO root password"
  default     = "minio123"
}

variable "minio_bucket_raw" {
  description = "MinIO raw bucket name"
  type        = string
  default     = "raw"
}

variable "minio_bucket_processed" {
  description = "MinIO processed bucket name"
  type        = string
  default     = "processed"
}

# --------------------------
# MLFLOW
# --------------------------
variable "mlflow_namespace" {
  description = "Namespace for MLflow and PostgreSQL"
  default     = "mlflow"
}

# terraform apply -var="mlflow_image=mlflow-custom:latest"
variable "mlflow_image" {
  description = "Custom MLFlow Image"
#  default     = "ghcr.io/mlflow/mlflow:v2.18.0"
  default     = "ghcr.io/viniciusmarchi/custom-mlflow:latest"
}

variable "mlflow_tracking_uri" {
  description = "MLflow serve deployment URI"
  type        = string
  default     = "http://mlflow.mlflow.svc.cluster.local:80"
}

variable "mlflow_deployment_serve_uri" {
  description = "MLflow serve deployment URI"
  type        = string
  default     = "http://mlflow-model-service.airflow.svc.cluster.local:5001/invocations"
}

variable "mlflow_experiment_name" {
  description = "MLflow experiment name"
  type        = string
  default     = "fraud-detection-experiment"
}

# --------------------------
# AIRFLOW
# --------------------------
variable "postgres_db" {
  description = "PostgreSQL database name"
  default     = "mlflow"
}

variable "postgres_user" {
  description = "PostgreSQL username"
  default     = "mlflow"
}

variable "postgres_password" {
  description = "PostgreSQL password"
  default     = "mlflow"
}

variable "airflow_namespace" {
  description = "Namespace for Airflow"
  default     = "airflow"
}

# --------------------------
# STREAMLIT
# --------------------------
variable "streamlit_namespace" {
  description = "Namespace for Streamlit"
  default     = "streamlit"
}

variable streamlit_image {
  default     = "ghcr.io/viniciusmarchi/streamlit-ui:latest"
}





variable "grafana_namespace" {
  description = "Namespace for Grafana"
  default     = "grafana"
}

variable "prometheus_namespace" {
  description = "Namespace for Prometheus"
  default     = "prometheus"
}
