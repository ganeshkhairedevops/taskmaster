# 📋 TaskMaster Pro - Modern Task Management System

[![Python](https://img.shields.io/badge/Python-3.9+-blue?style=flat-square&logo=python)](https://www.python.org/)
[![Flask](https://img.shields.io/badge/Flask-2.3.0-green?style=flat-square&logo=flask)](https://flask.palletsprojects.com/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-blue?style=flat-square&logo=postgresql)](https://www.postgresql.org/)
[![Docker](https://img.shields.io/badge/Docker-Enabled-blue?style=flat-square&logo=docker)](https://www.docker.com/)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-Ready-326ce5?style=flat-square&logo=kubernetes)](https://kubernetes.io/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

TaskMaster Pro is a modern, full-stack task management system built with Flask, PostgreSQL, and featuring a beautiful glassmorphism UI. It includes user authentication, real-time task updates, and comprehensive DevOps integration with Jenkins and Kubernetes.

## ✨ Features.

- 🎨 Modern glassmorphism UI with responsive design
- 🔐 Secure user authentication with session management
- 📋 Full CRUD task management with priority levels
- 👤 User isolation - each user sees only their tasks
- 📊 Real-time statistics dashboard
- 🐳 Docker containerization ready
- ☸️ Kubernetes deployment manifests
- 🚀 CI/CD pipeline with Jenkins
- 💾 PostgreSQL database with health checks
- 🔒 Security best practices implemented

## 🏗️ Architecture

TaskMaster follows a three-tier architecture pattern:

### 1. Presentation Tier (Frontend)
- HTML5 with modern CSS3 (Glassmorphism)
- Vanilla JavaScript for interactivity
- Responsive design for all devices
- Real-time UI updates
- Modern form validation

### 2. Application Tier (Backend)
- Flask web framework
- SQLAlchemy ORM for database operations
- Session-based authentication
- RESTful API endpoints
- Business logic processing
- Input validation and sanitization

### 3. Data Tier (Database)
- PostgreSQL 15 database
- User and task data models
- ACID compliance
- Data integrity constraints
- Optimized queries

```mermaid
flowchart TD
    %% Presentation Tier
    subgraph PT[Presentation Tier]
        direction TB
        UI[HTML/CSS/JS Frontend]
        FORMS[Login/Register Forms]
        DASH[Task Dashboard]
        UI -->|User Actions| FORMS
        FORMS -->|Authentication| DASH
    end

    %% Application Tier
    subgraph AT[Application Tier]
        direction TB
        FLASK[Flask Application]
        AUTH[Authentication System]
        API[REST API Endpoints]
        ORM[SQLAlchemy ORM]
        UI -->|HTTP Requests| FLASK
        FLASK -->|Session Check| AUTH
        AUTH -->|API Calls| API
        API -->|Database Ops| ORM
    end

    %% Data Tier
    subgraph DT[Data Tier]
        direction TB
        DB[(PostgreSQL Database)]
        USERS[Users Table]
        TASKS[Tasks Table]
        ORM -->|SQL Queries| DB
        DB -->|Relations| USERS
        DB -->|Relations| TASKS
    end

    %% Styling
    style PT fill:#e1f5fe,stroke:#01579b
    style AT fill:#e3f2fd,stroke:#0277bd
    style DT fill:#f3e5f5,stroke:#4a148c
    style DB fill:#f3e5f5,stroke:#4a148c,stroke-width:2px
```

### Key Features of the Architecture
- **Separation of Concerns**: Each tier has specific responsibilities
- **Scalability**: Independent scaling capabilities
- **Security**: Session-based authentication with password hashing
- **Maintainability**: Clean code organization
- **Performance**: Optimized database queries and caching

### Data Flow
1. User interacts with the web interface
2. Frontend sends requests to Flask backend
3. Authentication middleware validates sessions
4. API endpoints process business logic
5. SQLAlchemy ORM handles database operations
6. PostgreSQL stores and retrieves data
7. Response flows back through the tiers

## 🚀 Getting Started

### Docker Setup Guide

Run TaskMaster using Docker containers - no local Python or PostgreSQL installation required!

### Prerequisites

1. Install [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/)
2. Basic understanding of terminal/command line

### Step 1: Quick Start

```bash
# Clone the repository
git clone https://github.com/ganeshkhairedevops/taskmaster.git
cd taskmaster

# Start all services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop all services
docker-compose down
```

### Step 2: Manual Docker Commands

If you prefer more control:

```bash
# Build the application image
docker build -t taskmaster .

# Create a network
docker network create taskmaster-network

# Start PostgreSQL
docker run -d \
  --name taskmaster-postgres \
  --network taskmaster-network \
  -e POSTGRES_DB=taskmaster \
  -e POSTGRES_USER=taskmaster \
  -e POSTGRES_PASSWORD=taskmaster123 \
  -p 5433:5432 \
  postgres:15

# Start TaskMaster application
docker run -d \
  --name taskmaster-app \
  --network taskmaster-network \
  -p 5000:5000 \
  -e DATABASE_URL=postgresql://taskmaster:taskmaster123@taskmaster-postgres:5432/taskmaster \
  taskmaster
```

### Accessing the Application

1. Open your web browser
2. Visit [http://localhost:5000](http://localhost:5000)
3. Register a new account or login
4. Start managing your tasks!

## ☸️ Kubernetes Deployment

TaskMaster is ready for Kubernetes deployment with comprehensive manifests.

### Prerequisites

- Kubernetes cluster (local or cloud)
- kubectl configured
- Basic Kubernetes knowledge

### Quick Deployment

```bash
# Deploy to Kubernetes
cd k8s
./deploy.sh

# Check deployment status
kubectl get pods -n taskmaster

# Access the application
./port-forward.sh
```

### Manual Kubernetes Deployment

```bash
# Create namespace
kubectl apply -f k8s/01.namespace.yml

# Create secrets and configmaps
kubectl apply -f k8s/02.secret.yml
kubectl apply -f k8s/03.configmap.yaml

# Create persistent storage
kubectl apply -f k8s/04.pv.yaml
kubectl apply -f k8s/05.pvc.yaml

# Deploy PostgreSQL
kubectl apply -f k8s/06.postgres-deployment.yaml
kubectl apply -f k8s/07.postgres-service.yaml

# Deploy TaskMaster application
kubectl apply -f k8s/08.app-deployment.yaml
kubectl apply -f k8s/09.app-service.yaml
```

### Cleanup

```bash
# Remove all resources
cd k8s
./cleanup.sh
```

## 🔧 CI/CD with Jenkins

TaskMaster includes a complete Jenkins pipeline for automated deployment.

### Pipeline Stages

1. **Git Clone**: Pulls latest code from repository
2. **Build**: Creates Docker image
3. **Docker Push**: Pushes image to Docker Hub
4. **Deploy**: Deploys using Docker Compose

### Jenkinsfile Overview

```groovy
pipeline {
    agent any
    stages {
        stage('git clone') { /* Clone repository */ }
        stage('build') { /* Build Docker image */ }
        stage('docker push') { /* Push to registry */ }
        stage('deploy') { /* Deploy application */ }
    }
}
```

### Setup Instructions

1. **Configure Jenkins**:
   - Install Docker plugin
   - Add Docker Hub credentials as `dockerHubCreds`
   - Create new pipeline job

2. **Pipeline Configuration**:
   - Point to your repository
   - Use the included Jenkinsfile
   - Configure webhook for automatic triggers

3. **Required Credentials**:
   - Docker Hub username/password
   - Git repository access (if private)

### Deployment Scripts

```bash
# Push to Docker Hub
./push-to-dockerhub.sh

# Kubernetes deployment
cd k8s
./deploy.sh

# Port forwarding for local access
./port-forward.sh
```

## 📦 Project Structure

```
taskmaster/
├── app.py                    # Main Flask application
├── requirements.txt          # Python dependencies
├── Dockerfile               # Docker image configuration
├── docker-compose.yml       # Multi-container setup
├── Jenkinsfile             # CI/CD pipeline definition
├── push-to-dockerhub.sh    # Docker Hub deployment script
├── templates/              # HTML templates
│   ├── index.html          # Main dashboard
│   └── login.html          # Authentication page
├── k8s/                    # Kubernetes manifests
│   ├── 01.namespace.yml    # Namespace definition
│   ├── 02.secret.yml       # Database secrets
│   ├── 03.configmap.yaml   # Configuration data
│   ├── 04.pv.yaml          # Persistent volume
│   ├── 05.pvc.yaml         # Persistent volume claim
│   ├── 06.postgres-deployment.yaml  # PostgreSQL deployment
│   ├── 07.postgres-service.yaml     # PostgreSQL service
│   ├── 08.app-deployment.yaml       # App deployment
│   ├── 09.app-service.yaml          # App service
│   ├── deploy.sh           # Deployment script
│   ├── cleanup.sh          # Cleanup script
│   └── port-forward.sh     # Port forwarding script
└── LICENSE                 # MIT license
```

## 🔧 API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/` | Main dashboard (requires auth) |
| GET | `/login` | Login page |
| POST | `/register` | User registration |
| POST | `/login` | User authentication |
| GET | `/logout` | User logout |
| GET | `/api/tasks` | List user's tasks |
| POST | `/api/tasks` | Create new task |
| PUT | `/api/tasks/{id}` | Update existing task |
| DELETE | `/api/tasks/{id}` | Delete task |
| GET | `/health` | Health check endpoint |

## 🧪 Testing

### Manual Testing

```bash
# Health check
curl http://localhost:5000/health

# API testing (requires authentication)
curl -X GET http://localhost:5000/api/tasks \
  -H "Cookie: session=your_session_cookie"
```

### Database Testing

```bash
# Connect to PostgreSQL
docker exec -it taskmaster-postgres psql -U taskmaster -d taskmaster

# Check tables
\dt

# View users
SELECT * FROM users;

# View tasks
SELECT * FROM tasks;
```

## 🔧 Troubleshooting

### Common Issues

1. **Port Already in Use**
```bash
# Check what's using port 5000
lsof -i :5000

# Kill the process
kill -9 <PID>
```

2. **Database Connection Issues**
```bash
# Check PostgreSQL logs
docker logs taskmaster-postgres

# Verify database connectivity
docker exec taskmaster-postgres pg_isready -U taskmaster
```

3. **Docker Build Issues**
```bash
# Clean Docker cache
docker system prune -a

# Rebuild without cache
docker build --no-cache -t taskmaster .
```

### Kubernetes Troubleshooting

```bash
# Check pod status
kubectl get pods -n taskmaster

# View pod logs
kubectl logs -f deployment/taskmaster-app -n taskmaster

# Describe problematic pods
kubectl describe pod <pod-name> -n taskmaster

# Check services
kubectl get svc -n taskmaster
```

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Make your changes
4. Test thoroughly
5. Commit your changes: `git commit -m 'Add amazing feature'`
6. Push to the branch: `git push origin feature/amazing-feature`
7. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Flask](https://flask.palletsprojects.com/) - Web framework
- [PostgreSQL](https://www.postgresql.org/) - Database
- [Docker](https://www.docker.com/) - Containerization
- [Kubernetes](https://kubernetes.io/) - Orchestration
- [Jenkins](https://www.jenkins.io/) - CI/CD

## 📫 Contact

For questions or feedback, please open an issue or contact the maintainers:

- Maintainer - [@ganeshkhairedevops](https://github.com/ganeshkhairedevops)
- Project Link: [https://github.com/ganeshkhairedevops/taskmaster](https://github.com/ganeshkhairedevops/taskmaster)

---

<div align="center">
  <p>
    Made with ❤️ for efficient task management
  </p>
</div>
