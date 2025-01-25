variable "namespace" {
  description = "Namespace for MLflow"
  type        = string
}

variable "postgres_host" {
  description = "PostgreSQL host"
  type        = string
}

variable "postgres_db" {
  description = "PostgreSQL database name"
  type        = string
}

variable "postgres_user" {
  description = "PostgreSQL username"
  type        = string
}

variable "postgres_password" {
  description = "PostgreSQL password"
  type        = string
}

variable "minio_endpoint" {
  description = "MinIO endpoint"
  type        = string
}

variable "minio_root_user" {
  description = "MinIO root user"
  type        = string
}

variable "minio_root_password" {
  description = "MinIO root password"
  type        = string
}

variable "mlflow_image" {
  description = "The Docker image for MLflow"
  type        = string
}