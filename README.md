# 🚀 Blogify Infrastructure & DevOps

Welcome to the **DevOps and Cloud-Native** core of the **Blogify** platform. This repository contains the complete infrastructure-as-code (IaC) and containerization configurations required to deploy the three-tier Blogify application in a scalable, production-ready environment.

---

## 🏗️ Cloud Architecture

The infrastructure leverages **AWS EKS (Elastic Kubernetes Service)** in Auto Mode, provisioned entirely via **Terraform**. The application itself is containerized using Docker and orchestrated via Kubernetes.

```text
[ Internet / Users ]
        │
        ▼ (Port 80)
┌─────────────────────────────────────────────────┐
│               EKS Cluster (AWS)                 │
│                                                 │
│  ┌─────────────────┐       ┌─────────────────┐  │
│  │   Frontend      │──────▶│    Backend      │  │
│  │ (React/Nginx)   │       │ (Node/Express)  │  │
│  │  2 Replicas     │       │   2 Replicas    │  │
│  └─────────────────┘       └─────────────────┘  │
│                                     │           │
│                                     ▼           │
│                            ┌─────────────────┐  │
│                            │   PostgreSQL    │  │
│                            │   (EBS gp3 PVC) │  │
│                            └─────────────────┘  │
└─────────────────────────────────────────────────┘
```

---

## 📂 Infrastructure Map

```text
Blogify/
├── k8s/                      # Kubernetes Manifests
│   ├── namespace.yaml        # Dedicated 'blogify' namespace
│   ├── storage-secrets.yaml  # DB credentials and EBS StorageClass/PVC
│   ├── database.yaml         # Stateful Postgres deployment
│   ├── backend.yaml          # Node.js API Deployment & Service
│   ├── frontend.yaml         # React UI Deployment & Service
│   └── network-policies.yaml # Zero-trust internal routing rules
├── terraform/                # Infrastructure as Code (AWS)
│   ├── provider.tf           # AWS provider and tagging configuration
│   ├── variables.tf          # Configurable deployment variables
│   ├── terraform.tfvars      # Environment-specific values
│   ├── vpc.tf                # Network configuration (Subnets, NAT)
│   └── eks.tf                # EKS Auto Mode cluster setup
├── docker-compose.yml        # Local container orchestration
└── Dockerfile(s)             # Located in /frontend and /backend
```

---

## 🐳 Local Development (Docker Compose)

For rapid local testing without spinning up cloud resources, use the provided Docker Compose configuration.

**Requirements**: Docker Desktop or Docker Engine installed.

```bash
# Start the full stack (Frontend, Backend, Database)
docker-compose up -d --build

# View logs
docker-compose logs -f

# Shut down and remove volumes
docker-compose down -v
```
*Frontend runs on `http://localhost:80` and Backend on `http://localhost:5000`.*

---

## ☁️ Cloud Deployment (Terraform & Kubernetes)

### 1. Provision AWS Infrastructure

Initialize and apply the Terraform modules to create the VPC and EKS cluster.

```bash
cd terraform
terraform init
terraform plan
terraform apply --auto-approve
```

*Note: Update `terraform.tfvars` if you need to deploy to a specific AWS region or change the cluster name.*

### 2. Connect to EKS
Once Terraform finishes, update your local kubeconfig:

```bash
aws eks update-kubeconfig --region us-east-1 --name blogify-eks
```

### 3. Deploy Kubernetes Manifests
Apply the modular Kubernetes configurations. Note that resources are applied in order to ensure the namespace and secrets exist before the pods are scheduled.

```bash
cd ../k8s

# 1. Create Namespace & Secrets
kubectl apply -f namespace.yaml
kubectl apply -f storage-secrets.yaml

# 2. Deploy Database
kubectl apply -f database.yaml

# 3. Deploy Application Stack
kubectl apply -f backend.yaml
kubectl apply -f frontend.yaml

# 4. Apply Network Policies (Security)
kubectl apply -f network-policies.yaml
```

### 4. Verify Deployment
Check the status of your pods and services:

```bash
kubectl get all -n blogify
```

To access the frontend locally (since a NodePort is used):
```bash
kubectl port-forward svc/blogify-frontend 8080:80 -n blogify
```
Then visit `http://localhost:8080` in your browser.

---

## 🔐 Security & Best Practices Implemented

- **Network Policies**: Strict egress/ingress rules ensuring the DB only accepts traffic from the Backend, and the Backend only accepts traffic from the Frontend.
- **Least Privilege**: Containers are configured with `runAsNonRoot: true` (where applicable), `allowPrivilegeEscalation: false`, and dropped Linux capabilities.
- **K8s Secrets**: Base64 encoded secrets injected cleanly via environment variables.
- **EKS Auto Mode**: Zero-node-management architecture letting AWS handle compute scaling securely.
- **Read-Only Filesystems**: Configured on backend containers to prevent runtime tampering.
