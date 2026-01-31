# Containerization Guide: Docker → Docker Compose → Kubernetes

A beginner-friendly guide explaining containerization concepts from Docker basics to Kubernetes orchestration.

---

## Table of Contents
1. [What is Docker?](#what-is-docker)
2. [Docker Compose](#docker-compose)
3. [Kubernetes](#kubernetes)
4. [Visual Architecture Comparison](#visual-architecture-comparison)
5. [When to Use What?](#when-to-use-what)
6. [Quick Reference](#quick-reference)

---

## What is Docker?

### The Problem
- **"It works on my machine"** - Applications behave differently across environments
- Dependency conflicts between projects
- Difficult to deploy applications consistently

### The Solution: Containers
Docker packages your application and all its dependencies into a **container** - a lightweight, portable unit that runs consistently anywhere.

### Key Concepts

**Dockerfile** = Recipe/instructions for building an image
- Contains instructions: install dependencies, copy code, set up environment
- Example: `FROM python:3.12`, `COPY . /app`, `RUN pip install requirements.txt`

**Docker Image** = Built immutable template/blueprint
- Built from a Dockerfile using `docker build`
- Like a snapshot or template that can be used to create containers
- Stored in registries (Docker Hub, Artifactory, etc.)
- No file extension - referenced by name/tag (e.g., `monk-frontend:latest`)

**Docker Container** = Running instance created from an image
- Created from an image using `docker run`
- Like running a program from an executable
- Isolated from your system and other containers
- You can run multiple containers from the same image

### Basic Commands
```bash
# Build an image from a Dockerfile
docker build -t my-app ./my-app
# -t my-app          → Tags the image as "my-app"
# ./my-app           → Build context (directory Docker can access during build)
#                     Important: COPY commands in Dockerfile can only access files
#                     within this directory. Files outside are inaccessible.

# Run a container
docker run -p 8080:8080 my-app
# -p 8080:8080       → Maps port 8080 on your machine to port 8080 in the container
#                     Format: host-port:container-port
# my-app             → Name of the image to run

# List running containers
docker ps

# List images
docker images
```

---

## Docker Compose

### The Problem with Docker Alone
- Running multiple containers manually is tedious
- Managing networking between containers is complex
- No easy way to start/stop entire application stacks

### The Solution: Docker Compose
Docker Compose orchestrates multiple containers on **a single machine** using a simple YAML file.

### Key Features
- ✅ Define multiple containers in one file
- ✅ Automatic networking between containers
- ✅ Easy start/stop of entire application
- ✅ Volume management for data persistence
- ✅ Environment variable management

### Example `docker-compose.yml`
```yaml
version: '3.8'
services:
  frontend:
    image: monk-frontend
    ports:
      - "8080:8080"
  
  backend:
    image: monk-backend
    ports:
      - "8079:8079"
    environment:
      - DATABASE_URL=postgresql://db:5432/monk
  
  database:
    image: postgres:14
    volumes:
      - db-data:/var/lib/postgresql/data

volumes:
  db-data:
```

### Basic Commands
```bash
# Start all services
docker-compose up

# Start in background
docker-compose up -d

# Stop all services
docker-compose down

# View logs
docker-compose logs
```

---

## Kubernetes

### The Problem with Docker Compose
- Only works on one machine
- No automatic scaling
- No automatic recovery if containers crash
- Manual management of high availability

### The Solution: Kubernetes
Kubernetes orchestrates containers across **multiple machines (a cluster)** with advanced features for production environments.

### Key Concepts

**Cluster** = Group of machines (nodes) working together
- **Master Node**: Controls the cluster
- **Worker Nodes**: Run your containers

**Pod** = Smallest deployable unit (usually one container)
- Container(s) running on a node

**Deployment** = Manages pods (scaling, updates, rollbacks)
- Ensures desired number of pods are running
- Handles rolling updates

**Service** = Network endpoint for pods
- Load balancing
- Service discovery

**Helm Chart** = Package of Kubernetes configurations
- Templates for Deployments, Services, ConfigMaps, etc.
- Makes Kubernetes deployments manageable

### Key Features
- ✅ **Multi-server**: Distributes containers across machines
- ✅ **Auto-scaling**: Adds/removes containers based on load
- ✅ **Self-healing**: Restarts failed containers automatically
- ✅ **Rolling updates**: Deploy without downtime
- ✅ **Load balancing**: Distributes traffic across containers
- ✅ **Health checks**: Monitors container health
- ✅ **Secrets management**: Secure credential handling

---

## Visual Architecture Comparison

### Docker Compose Architecture
```
┌────────────────────────────────────────┐
│         Your Computer/Server           │
│                                        │
│  ┌──────────────┐    ┌──────────────┐  │
│  │   Frontend   │    │   Backend    │  │
│  │   Container  │◄───┤  Container   │  │
│  │   Port 8080  │    │  Port 8079   │  │
│  └──────────────┘    └──────┬───────┘  │
│                             │          │
│                    ┌────────▼───────┐  │
│                    │   Database     │  │
│                    │   Container    │  │
│                    │   Port 5432    │  │
│                    └────────────────┘  │
│                                        │
│  Docker Compose manages all containers │
│  on this single machine                │
└────────────────────────────────────────┘
```

**Characteristics:**
- All containers on one machine
- Simple networking
- Manual scaling
- Single point of failure

### Kubernetes Architecture
```
┌──────────────────┐  ┌──────────────────┐  ┌──────────────────┐
│   Worker Node 1  │  │   Worker Node 2  │  │   Worker Node 3  │
│                  │  │                  │  │                  │
│ ┌──────────────┐ │  │ ┌──────────────┐ │  │ ┌──────────────┐ │
│ │   Frontend   │ │  │ │   Frontend   │ │  │ │   Backend    │ │
│ │     Pod      │ │  │ │     Pod      │ │  │ │     Pod      │ │
│ └──────────────┘ │  │ └──────────────┘ │  │ └──────────────┘ │
│                  │  │                  │  │                  │
│ ┌──────────────┐ │  │ ┌──────────────┐ │  │ ┌──────────────┐ │
│ │   Backend    │ │  │ │   Database   │ │  │ │   Database   │ │
│ │     Pod      │ │  │ │     Pod      │ │  │ │     Pod      │ │
│ └──────────────┘ │  │ └──────────────┘ │  │ └──────────────┘ │
└────────┬─────────┘  └────────┬─────────┘  └────────┬─────────┘
         │                     │                     │
         └─────────────────────┼─────────────────────┘
                               │
                    ┌───────────▼───────────┐
                    │   Master Node         │
                    │                       │
                    │  • API Server         │
                    │  • Scheduler          │
                    │  • Controller Manager │
                    │  • etcd (storage)     │
                    │                       │
                    │  Orchestrates all     │
                    │  containers across    │
                    │  worker nodes         │
                    └───────────────────────┘
```

**Characteristics:**
- Containers distributed across multiple machines
- Automatic load balancing
- Automatic scaling
- High availability (if one node fails, others continue)

---

## When to Use What?

### Use Docker When:
- ✅ Building a single container
- ✅ Learning containerization basics
- ✅ Simple applications
- ✅ Local development

### Use Docker Compose When:
- ✅ Multiple containers on one machine
- ✅ Local development environment
- ✅ Small applications
- ✅ CI/CD testing
- ✅ Single-server deployments
- ✅ Quick prototypes

### Use Kubernetes When:
- ✅ Production deployments
- ✅ Need high availability
- ✅ Need automatic scaling
- ✅ Multiple servers/cluster
- ✅ Enterprise applications
- ✅ Need advanced features:
  - Rolling updates
  - Self-healing
  - Advanced networking
  - Secrets management
  - Resource limits

---

## Quick Reference

### Comparison Table

| Feature | Docker | Docker Compose | Kubernetes |
|---------|--------|----------------|------------|
| **Scope** | Single container | Multiple containers, one machine | Multiple containers, multiple machines |
| **Complexity** | 🟢 Simple | 🟡 Moderate | 🔴 Complex |
| **Learning Curve** | Easy | Moderate | Steep |
| **Auto-scaling** | ❌ | ❌ | ✅ |
| **High Availability** | ❌ | ❌ | ✅ |
| **Self-healing** | ❌ | ❌ | ✅ |
| **Load Balancing** | ❌ | ⚠️ Basic | ✅ |
| **Rolling Updates** | ❌ | ❌ | ✅ |
| **Multi-server** | ❌ | ❌ | ✅ |
| **Best For** | Learning, simple apps | Development, small apps | Production, enterprise |

### The Evolution Path

```
Docker (Single Container)
    ↓
    Learn: How containers work
    ↓
Docker Compose (Multiple Containers, One Machine)
    ↓
    Learn: Container orchestration basics
    ↓
Kubernetes (Multiple Containers, Multiple Machines)
    ↓
    Learn: Production-grade orchestration
```

### Real-World Analogy

- **Docker** = Running a single program on your computer
- **Docker Compose** = Running multiple programs together on your computer
- **Kubernetes** = Running a data center with automatic management

---

## Summary

1. **Docker** packages applications into containers for consistent execution
2. **Docker Compose** orchestrates multiple containers on a single machine
3. **Kubernetes** orchestrates containers across multiple machines with production features

**Start simple**: Learn Docker first, then Docker Compose, then Kubernetes when you need production-grade features.

---

## Additional Resources

- **Docker**: [docker.com/get-started](https://www.docker.com/get-started)
- **Docker Compose**: [docs.docker.com/compose](https://docs.docker.com/compose/)
- **Kubernetes**: [kubernetes.io/docs](https://kubernetes.io/docs/)

---

