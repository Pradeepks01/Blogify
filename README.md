# ✍️ Blogify — The Modern Micro-Blogging Engine

**Blogify** is a sleek, high-performance web application designed for seamless content sharing. It leverages a modern three-tier architecture to deliver a smooth user experience backed by robust server-side processing and reliable data storage.

> **Note on Environments**: You are currently viewing the core project documentation. To explore the cloud-native, scalable infrastructure configuration (featuring Docker Compose, EKS Auto Mode Kubernetes manifests, and HashiCorp Terraform modules), switch your working branch to `devops`.
> ```bash
> git switch devops
> ```

---

## ✨ Core Capabilities

- **Rich Content Creation**: Draft and publish posts instantly with integrated mood/emoji indicators.
- **Dynamic Interactions**: Real-time commenting system to foster community engagement.
- **Content Management**: Full CRUD operations allowing authors to update or remove their stories.
- **Premium Interface**: A modern dark-mode aesthetic featuring fluid glassmorphism elements, micro-animations, and responsive layouts.

---

## 🏗️ System Architecture

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
     Port: 80 / 8080                  Port: 5000                     Port: 5432
```

---

## 📂 Repository Blueprint

```text
Blogify/
├── backend/                  # REST API Service
│   ├── src/                  # Controllers, routing, and DB logic
│   └── package.json          # Node dependencies
├── frontend/                 # Client UI Application
│   ├── src/                  # React views, assets, and styling
│   └── vite.config.js        # Build configuration
├── infrastructure/           # Deployment Assets
│   ├── setup.sh              # Automated provisioning script for EC2
│   └── blogify-nginx.conf    # Server block configurations
└── README.md                 # Project documentation
```

---

## 💻 Local Development Setup

To run Blogify locally without containerization, ensure you have **Node.js v20+** and **PostgreSQL v16+** installed.

### 1. Database & API
Navigate to the backend directory and set up your environment variables:

```bash
cd backend
npm install

# Initialize environment configuration
export DB_HOST=localhost
export DB_PORT=5432
export DB_USER=blogify_user
export DB_PASSWORD=blogify_pass_2026
export DB_NAME=blogify_db
export PORT=5000

npm start
```

### 2. Client Interface
In a separate terminal, launch the frontend development server:

```bash
cd frontend
npm install
npm run dev
```
The application will be accessible at `http://localhost:3000`.

---

## 🚀 Bare-Metal EC2 Deployment

For a traditional VM-based deployment, we provide an automated shell script that configures an Ubuntu EC2 instance from scratch.

**Requirements**: Ubuntu 22.04+ EC2 instance with ports 22 and 80 open.

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

The script automatically handles package updates, Node/PostgreSQL installations, database seeding, React compilation, PM2 daemonization, and Nginx reverse proxy routing.

---

## 📡 API Reference Manual

| Method | Route | Action |
|--------|-------|--------|
| `GET` | `/api/health` | Verify API status |
| `GET` | `/api/posts` | Retrieve feed |
| `GET` | `/api/posts/:id` | Fetch specific post + threads |
| `POST` | `/api/posts` | Publish new content |
| `PUT` | `/api/posts/:id` | Modify existing content |
| `DELETE` | `/api/posts/:id` | Remove content |
| `GET` | `/api/comments/post/:id`| Load comment thread |
| `POST` | `/api/comments` | Add response |
| `DELETE` | `/api/comments/:id` | Delete response |

---

## 🌿 Version Control Strategy

- **`main`**: The stable branch. Contains the raw application source code and traditional bare-metal EC2 deployment scripts.
- **`devops`**: The cloud-native branch. Contains advanced deployment strategies including Docker configurations, Kubernetes (EKS) manifests broken down into logical components, and Terraform IaC definitions.
