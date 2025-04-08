# Fraud Detection Project

## Table of Contents
1. [Overview](#overview)  
2. [Key Features & Technologies](#key-features--technologies)  
3. [Project Details](#project-details)  
    - [Project Architecture](#project-architecture)  
    - [Project Structure](#project-structure)  
    - [MLOps Components](#mlops-components)  
        - [Kubernetes (Minikube)](#kubernetes-minikube)  
        - [Airflow](#airflow)  
        - [MinIO](#minio)  
        - [MLflow](#mlflow)  
        - [Streamlit](#streamlit)  
    - [CI/CD with GitHub Actions](#cicd-with-github-actions)  
4. [Local Setup & Deployment](#local-setup--deployment)  
5. [Usage](#usage)  
    - [Running Airflow DAGs](#running-airflow-dags)  
    - [Using the Streamlit App](#using-the-streamlit-app)  

## Overview
This project demonstrates a fraud detection pipeline from raw data ingestion to model deployment and monitoring. It’s designed as an **end-to-end MLOps** project, featuring:

- Automated data ingestion and processing (cleaning, handling class imbalance with SMOTE, data types, and feature engineering)
- Model development with scikit-learn and MLflow tracking (both Logistic Regression and Random Forest classifiers are trained and hyperparameter-tuned to maximize recall, with all runs tracked in MLflow)
- Model storage/versioning in the MLflow Model Registry 
- Containerized tasks orchestrated in Kubernetes via Airflow  
- CI/CD pipelines with GitHub Actions to build Docker images and deploy automatically  
- Real-time or batch scoring with a Streamlit UI  

## Key Features & Technologies
- **Frameworks & Libraries**: pandas, scikit-learn, imbalanced-learn, MLflow  
- **Orchestration**: Apache Airflow (KubernetesPodOperator)  
- **Data Storage**: MinIO (S3-compatible object store)  
- **Containerization**: Docker + Kubernetes  
- **CI/CD**: GitHub Actions (build & push Docker images to GitHub Container Registry)  
- **Dashboard**: Streamlit for inference & analytics  
- **Infrastructure as Code**: Terraform  


## Project Details

### Project Architecture
![diagram](./assets/diagram.png)


### Project Structure

```
./
├── dags/
│   ├── deploy_model_dag.py     # Airflow DAG to deploy the trained model
│   └── etl_train_dag.py        # Airflow DAG to ingest and train the fraud detection model
├── docker/
│   ├── airflow/                # Dockerfile for custom Airflow
│   ├── data_ingestion/         # Dockerfile for data ingestion
│   ├── data_preparation/       # Dockerfile for data prep
│   ├── mlflow/                 # Dockerfile for custom MLflow
│   ├── streamlit/              # Dockerfile for Streamlit
│   └── train/                  # Dockerfile for model training
├── src/
│   ├── data_ingestion/         # Python scripts for ingestion
│   ├── data_preparation/       # Python scripts for data cleaning, feature engineering and processing
│   ├── train/                  # Model training scripts
│   └── ui/                     # Streamlit app & utility functions
├── terraform/                  # IaC with Terraform
└── .github/workflows/          # GitHub Actions to build Docker images and deploy automatically
```

### MLOps Components

#### Kubernetes (Minikube)
A local Kubernetes cluster that:
- **Deploys** containerized services (MinIO, MLflow, Airflow, Streamlit)
- **Runs** containerized tasks in Airflow DAGs via the **KubernetesPodOperator**

#### Airflow
- **Manages** the pipeline:
  - `etl_train_dag.py`: Data ingestion → Data preparation → Model training → MLflow logging  
  - `deploy_model_dag.py`: Retrieves the best model from MLflow → Deploys it on Kubernetes

#### MinIO
An S3-compatible object store:
- **Raw Bucket**: Stores original CSV data  
- **Processed Bucket**: Stores feature-engineered data, scalers, etc.

#### MLflow
Handles model development and tracking:
- Trains both Logistic Regression and Random Forest classifiers, tuned for recall
- Tracks all runs in MLflow
- Automatically registers the best model in the Model Registry for deployment

Key Features:
- **Experiment Tracking**: Logs metrics, hyperparameters, artifacts  
- **Model Registry**: Version control for models  

#### Streamlit
An interactive UI for:
- **Single-transaction** fraud detection  
- **Batch scoring** with performance metrics and visualizations  

---

### CI/CD with GitHub Actions
Each Docker image (Airflow, data ingestion, data preparation, MLflow, training, and Streamlit) is **automatically built** and pushed to **GitHub Container Registry** when changes are detected in relevant directories. This ensures consistent, up-to-date containers in the Kubernetes cluster.

---

## Local Setup & Deployment

### Prerequisites
1. **Minikube**  
2. **Terraform**  
3. **Docker** (for local builds)
4. **kubectl** (to interact with Kubernetes)

### 1. Start Minikube
```bash
minikube start
```

### 2. Clone This Repository
```bash
git clone https://github.com/ViniciusMarchi/fraud-detector-mlops 
cd fraud-detector-mlops
```

### 3. Set Up Environment Variables (Optional)
You can customize credentials and configurations in `terraform/variables.tf`.

### 4. Initialize and Apply Terraform
```bash
cd terraform
terraform init
terraform apply -auto-approve
```

This will:
- Create namespaces
- Deploy all services (MinIO, MLflow, Airflow, PostgreSQL, Streamlit, Grafana, Prometheus)
- Expose them via NodePorts

### 5. Verify Deployments
```bash
kubectl get pods -A
```

### 6. Retrieve Minikube IP
```bash
minikube ip
```

### 7. Access Services

| Service        | URL                                   | NodePort | Notes                                |
|----------------|----------------------------------------|----------|--------------------------------------|
| Airflow        | `http://<MINIKUBE_IP>:31000`          | 31000    | Credentials in `values.yaml`        |
| MLflow         | `http://<MINIKUBE_IP>:30080`          | 30080    | MLflow UI + Artifacts                |
| MinIO (UI)     | `http://<MINIKUBE_IP>:30091`          | 30091    | MinIO console                        |S3-compatible endpoint               |
| Streamlit      | `http://<MINIKUBE_IP>:30007`          | 30007    | Fraud detection app                  |

> 💡 You can change NodePorts in Terraform if there are conflicts.

---

## Usage

### Running Airflow DAGs
1. Go to Airflow: `http://<MINIKUBE_IP>:31000`
2. Enable and trigger:
   - `etl_train_dag` to run ingestion, preparation, and training (logs to MLflow)
   - `deploy_model_dag` to deploy the best model

### Using the Streamlit App
Go to: `http://<MINIKUBE_IP>:30007`

- **Single Inference**: Enter transaction details for a real-time fraud prediction  
- **Batch Inference**: Upload datasets (e.g. `fraudTest.csv` from [Credit Card Transactions Fraud Detection Dataset](https://www.kaggle.com/datasets/kartik2112/fraud-detection)) and view results (charts, metrics, confusion matrix)