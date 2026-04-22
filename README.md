# ✍️ Blogify — Enterprise DevSecOps Blog Platform

**Blogify** is a modern, 3-tier micro-blogging engine engineered with a high-performance React frontend, Node.js API, and PostgreSQL database. This project serves as a full-scale demonstration of **Cloud-Native DevSecOps**, featuring automated infrastructure provisioning, container orchestration, and a robust multi-stage security pipeline.

---

## 🚀 Overview

- **Architecture**: Decoupled 3-tier stack (React + Node.js + PostgreSQL).
- **Containerization**: Fully Dockerized components with multi-stage builds.
- **Orchestration**: Production-grade Kubernetes on **AWS EKS (Auto Mode)**.
- **IaC**: Infrastructure-as-Code via **HashiCorp Terraform** (VPC, EKS, IAM).
- **CI/CD**: Advanced 10-stage DevSecOps pipeline powered by **GitHub Actions**.

---

## 🛡️ Security & DevSecOps Practices

The project implements a "Shift-Left" security approach, validating every layer from code to cloud:

- ✅ **Static Analysis**: ESLint code linting for frontend and backend.
- ✅ **SCA (Software Composition Analysis)**: `npm audit` for identifying vulnerable dependencies.
- ✅ **Image Security**: **Trivy** vulnerability scanning for all container images.
- ✅ **Dockerfile Linting**: **Hadolint** to enforce container best practices.
- ✅ **IaC Security**: **Checkov** scanning for Terraform and Kubernetes manifests.
- ✅ **Zero-Trust Networking**: Kubernetes **NetworkPolicies** restricting pod-to-pod communication.
- ✅ **Hardened Containers**: Non-root users, read-only filesystems, and dropped Linux capabilities.
- ✅ **Data Security**: EKS Secrets encryption at rest using AWS KMS integration.

---

## 🎡 CI/CD Pipeline (All Stages)

The GitHub Actions pipeline is triggered on every push to `main`, `devops`, or `test` branches:

1. **🔍 Lint Scanning** — Validates code quality and syntax.
2. **🛡️ Dependency Audit (SCA)** — Scans for insecure third-party libraries.
3. **📋 Dockerfile Lint** — Enforces secure and efficient container builds.
4. **🏗️ IaC Security Scan** — Validates Terraform and K8s manifests for misconfigurations.
5. **🐳 Container Build** — Generates optimized multi-stage Docker images.
6. **🐳 Push to GHCR** — Securely hosts images in GitHub Container Registry.
7. **🔬 Image Scan** — Deep scanning of built images using Trivy.
8. **🚀 Auto-update Manifests** — GitOps-style automation updating image tags in Kubernetes files.

---

## 🛠️ Tech Stack

- **Frontend**: React 18, Vite, Nginx (Alpine), CSS3 (Glassmorphism).
- **Backend**: Node.js 20, Express.js.
- **Database**: PostgreSQL 16.
- **Infrastructure**: Terraform, AWS (VPC, EKS, EBS, IAM).
- **DevOps**: Docker, Kubernetes, GitHub Actions, GHCR.
- **Security Tools**: Trivy, Checkov, Hadolint, ESLint, npm audit.

---

## 📂 Project Structure

```text
Blogify/
├── frontend/                # React application + Nginx config
├── backend/                 # Node.js Express API + DB layer
├── infrastructure/          # EC2 bare-metal setup (main branch focus)
├── kubernetes/              # Modular K8s manifests (namespace, secrets, networking)
├── terraform/               # AWS Infrastructure as Code
└── .github/workflows/       # 10-stage DevSecOps pipeline definition
```

---

## 🌿 Branch Strategy

| Branch | Purpose |
|--------|---------|
| **`main`** | Source code + Traditional EC2 bare-metal deployment. |
| **`devops`** | Cloud-Native core: Docker, K8s, Terraform, and DevSecOps pipelines. |
| **`test`** | Experimental branch for testing new features and CI/CD upgrades. |

---

## 📡 API Reference

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/health` | Service health status |
| `GET` | `/api/posts` | Fetch all stories |
| `POST` | `/api/posts` | Publish a new story |
| `PUT` | `/api/posts/:id` | Edit an existing story |
| `DELETE` | `/api/posts/:id` | Remove a story |
| `POST` | `/api/comments` | Add a response thread |

---

## 🏃 Quick Start (Local Docker)

To run the entire ecosystem locally in seconds:

```bash
docker-compose up -d --build
```
*Access the UI at `http://localhost:80`.*
