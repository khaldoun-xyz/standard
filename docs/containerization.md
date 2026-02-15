# Containerization Guide: Docker → Docker Compose → Kubernetes

A beginner-friendly guide explaining containerization concepts from Docker basics to Kubernetes orchestration.

---

## Table of Contents
1. [What is Docker?](#what-is-docker)
2. [Base Images](#base-images)
3. [Docker Compose](#docker-compose)
4. [Kubernetes](#kubernetes)
5. [Visual Architecture Comparison](#visual-architecture-comparison)
6. [When to Use What?](#when-to-use-what)
7. [Quick Reference](#quick-reference)

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

### Base Images

**Base Image** = The starting point for building your Docker image
- Specified with the `FROM` instruction in a Dockerfile
- Contains the operating system and basic tools
- Everything you build adds on top of this foundation

#### What is a Base Image?

Think of a base image like the foundation of a house:
- **Base Image** = Foundation (OS, basic tools)
- **Your Layers** = Everything you add (your app, dependencies)

#### Common Base Images

**Official Images:**
- `node:20-alpine` - Node.js 20 on Alpine Linux (small, ~50MB)
- `python:3.12` - Python 3.12 on Debian (larger, ~900MB)
- `nginx:alpine` - Nginx web server on Alpine Linux (~25MB)
- `ubuntu:22.04` - Full Ubuntu Linux (~80MB)

**Enterprise Images:**
- `micromamba:2025.08.26` - Enterprise package manager with pre-configured tools
- Custom images from private registries (Artifactory, etc.)

#### Why Base Images Are Useful

**1. Pre-installed Software**
- Base images come with software already installed
- Example: `node:20-alpine` has Node.js 20 ready to use
- No need to install from scratch

**2. Consistency**
- Same base image = same environment everywhere
- Works the same on your laptop, CI/CD, and production
- Eliminates "works on my machine" problems

**3. Security & Updates**
- Base images are maintained and updated regularly
- Security patches applied by maintainers
- You benefit from community/enterprise maintenance

**4. Size Optimization**
- Different base images have different sizes
- `alpine` images are very small (~5-50MB)
- `debian/ubuntu` images are larger (~80-900MB)
- Choose based on your needs

**5. Enterprise Features**
- Enterprise base images include:
  - Pre-configured authentication (Artifactory, etc.)
  - Enterprise certificates
  - Compliance settings
  - Standardized tooling

#### Example: Base Image Comparison

**Building a Node.js App:**

**Option 1: Start from Scratch**
```dockerfile
FROM scratch  # Empty image
# Need to install Linux, Node.js, npm, everything...
# Very complex, time-consuming
```

**Option 2: Use Base Image**
```dockerfile
FROM node:20-alpine
# Node.js 20 already installed!
# Just add your code
COPY . .
RUN npm install
```

**Option 3: Enterprise Base Image**
```dockerfile
FROM micromamba:2025.08.26
# Enterprise tools pre-configured
# Artifactory authentication ready
# Compliance settings applied
```

#### Choosing a Base Image

**Considerations:**
- ✅ **Size**: Smaller = faster downloads, less storage
- ✅ **Security**: Regularly updated, minimal attack surface
- ✅ **Compatibility**: Works with your application
- ✅ **Enterprise**: Meets compliance requirements
- ✅ **Maintenance**: Actively maintained

**Common Choices:**
- **Development**: `node:20-alpine` (small, fast)
- **Production**: Official images or enterprise-approved images
- **Enterprise**: Custom images from your organization's registry

#### Multi-Stage Builds and Base Images

You can use different base images for different stages:

```dockerfile
# Stage 1: Build (large base image with build tools)
FROM node:20-alpine as builder
RUN npm install
RUN npm run build

# Stage 2: Production (small base image, just runtime)
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
```

**Benefits:**
- Build stage: Large image with all tools (discarded)
- Production stage: Small image with only what's needed (kept)
- Final image is much smaller!

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

