# ✍️ Blogify — The Ultimate Micro-Blogging Engine

**Blogify** is a sleek, high-performance web application designed for seamless content sharing. It leverages a modern three-tier architecture to deliver a smooth user experience backed by robust server-side processing, reliable data storage, and enterprise-grade DevSecOps infrastructure.

---

## ✨ Features
- **📝 Create & Edit**: Draft and publish posts instantly with integrated mood/emoji indicators.
- **💬 Community Threads**: Real-time commenting system to foster community engagement.
- **🗑️ Full Control**: Complete CRUD operations allowing authors to update or remove their stories.
- **🎨 Premium Interface**: A modern dark-mode aesthetic featuring fluid glassmorphism elements, micro-animations, and responsive layouts.

---

## 🏗️ Architecture

The platform operates on a decoupled architecture ensuring separation of concerns:

```text
[ Client Device ]
       │
       ▼ (HTTP/REST)
┌──────────────────────┐      ┌────────────────────────┐      ┌──────────────────────┐
│  Presentation Layer  │      │    Application Layer   │      │      Data Layer      │
│  (React.js & Vite)   │ ───▶ │   (Node.js / Express)  │ ───▶ │     (PostgreSQL)     │
│   Served via Nginx   │ ◀─── │   Stateless API Host   │ ◀─── │ Relational Storage   │
└──────────────────────┘      └────────────────────────┘      └──────────────────────┘
```

---

## 📂 Repository Blueprint

```text
Blogify/
├── frontend/                 # React (Vite) frontend application
├── backend/                  # Node.js Express API service
├── infrastructure/           # EC2 bare-metal automated deployment scripts
├── kubernetes/               # Modular Kubernetes manifests (Deployments, Services, Secrets)
├── terraform/                # Infrastructure-as-Code for AWS EKS provisioning
├── docker-compose.yml        # Local container orchestration
└── README.md                 # Full project documentation
```

---

## 📡 API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/health` | API health check |
| `GET` | `/api/posts` | Retrieve all blog posts |
| `GET` | `/api/posts/:id` | Fetch specific post with comments |
| `POST` | `/api/posts` | Create a new blog post |
| `PUT` | `/api/posts/:id` | Update an existing post |
| `DELETE` | `/api/posts/:id` | Delete a blog post |
| `GET` | `/api/comments/post/:postId` | Get all comments for a specific post |
| `POST` | `/api/comments` | Create a new comment |
| `DELETE` | `/api/comments/:id` | Delete a comment |

---

## 🌿 Branch Strategy

The project utilizes a strict branching strategy to separate bare-metal code from cloud-native infrastructure:

| Branch | Purpose |
|--------|---------|
| **`main`** | Source code + Traditional EC2 bare-metal deployment (`infrastructure/setup.sh`). |
| **`devops`** | Full Cloud-Native Infrastructure — Docker, Kubernetes (AWS EKS Auto Mode), Terraform IaC, and security scanning. |
| **`test`** | Experimental branch used for testing new integrations and CI/CD pipelines. |

---

## 💻 Local Development (Without Docker)

To run Blogify locally natively, ensure you have **Node.js v20+** and **PostgreSQL v16+** installed.

### 1. Database & API
```bash
cd backend
npm install

# Initialize environment variables
export DB_HOST=localhost
export DB_PORT=5432
export DB_USER=blogify_user
export DB_PASSWORD=blogify_pass_2026
export DB_NAME=blogify_db
export PORT=5000

npm start
```

### 2. Client Interface
In a separate terminal:
```bash
cd frontend
npm install
npm run dev
```
*Frontend runs on `http://localhost:3000` and proxies `/api` to `http://localhost:5000`.*

---

## 🐳 Local Development (Docker Compose)

For rapid local testing without installing native dependencies:

```bash
# Start the full stack (Frontend, Backend, Database)
docker-compose up -d --build

# View logs
docker-compose logs -f

# Shut down
docker-compose down -v
```
*Frontend runs on `http://localhost:80` and Backend on `http://localhost:5000`.*

---

## ☁️ Cloud Deployment (Terraform & Kubernetes)

Deploy the full stack to AWS EKS using the Terraform modules and Kubernetes manifests located in the `devops` branch.

### 1. Provision AWS Infrastructure
```bash
cd terraform
terraform init
terraform apply --auto-approve
```
*Connect to EKS:* `aws eks update-kubeconfig --region us-east-1 --name blogify-eks`

### 2. Deploy Kubernetes Manifests
```bash
cd ../kubernetes
kubectl apply -f namespace.yaml
kubectl apply -f storage-secrets.yaml
kubectl apply -f database.yaml
kubectl apply -f backend.yaml
kubectl apply -f frontend.yaml
kubectl apply -f network-policies.yaml
```
*Access:* `kubectl port-forward svc/blogify-frontend 8080:80 -n blogify`

---

## 🚀 Bare-Metal EC2 Deployment

For a traditional VM-based deployment, use the automated shell script on an Ubuntu 22.04+ EC2 instance.

1. **Upload Source Code**:
   ```bash
   scp -r -i your-ssh-key.pem ./Blogify ubuntu@<EC2_IP_ADDRESS>:~/Blogify
   ```

2. **Connect & Provision**:
   ```bash
   ssh -i your-ssh-key.pem ubuntu@<EC2_IP_ADDRESS>
   cd ~/Blogify
   chmod +x infrastructure/setup.sh
   ./infrastructure/setup.sh
   ```
*This script automatically handles Node, PostgreSQL, PM2, Nginx setup, and React compilation.*
