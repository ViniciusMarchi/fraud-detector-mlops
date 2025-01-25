variable "namespace" {
  description = "The Kubernetes namespace to deploy the app into"
  type        = string
  default     = "streamlit"
}

variable "image" {
  description = "The Docker image to deploy"
  type        = string
}

variable "mlflow_deployment_serve_uri" {
  description = "The MLFLOW_SERVE_DEPLOYMENT_URI environment variable"
  type        = string
}

variable "port" {
  description = "The port on which the application runs"
  type        = number
  default     = 8501
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
