output "mlflow_ui_url" {
  description = "URL to access the MLflow UI"
  value       = "http://$(minikube ip):30080"
}

output "minio_ui_url" {
  description = "URL to access the MinIO UI"
  value       = "http://$(minikube ip):30091"
}

output "minio_api_url" {
  description = "URL to access the MinIO API"
  value       = "http://$(minikube ip):30090"
}

output "streamlit_api_url" {
  description = "URL to access the Streamlit"
  value       = "http://$(minikube ip):30007"
}

output "grafana_ui_url" {
  description = "URL to access the Grafana UI"
  value       = "http://$(minikube ip):30300"
}

output "prometheus_ui_url" {
  description = "URL to access the Prometheus UI"
  value       = "http://$(minikube ip):30900"
}