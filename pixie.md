# Pixi Crash Course & Migration Guide

## What is Pixi?

**Pixi** is a fast, modern package and environment manager for Python and other languages. It's built on top of [Rattler](https://github.com/mamba-org/rattler), a Rust-based conda-compatible package manager, making it significantly faster than conda/mamba while maintaining compatibility.

### Key Benefits Over Conda/Mamba

- ⚡ **Much faster**: Built in Rust, pixi is 5-10x faster than conda/mamba
- 🔒 **Reproducible**: Lock files ensure exact dependency versions
- 🎯 **Project-scoped**: Each project has its own environment (no global environments)
- 🛠️ **Task runner**: Built-in task system (like npm scripts)
- 📦 **Multi-language**: Supports Python, R, Node.js, and more
- 🔄 **Conda-compatible**: Works with conda channels and packages

## Installation

### macOS/Linux
```bash
curl -fsSL https://pixi.sh/install.sh | bash
```

### Windows
```powershell
iwr https://pixi.sh/install.ps1 -useb | iex
```

### Or via Homebrew (macOS)
```bash
brew install pixi
```
Verify installation:
```bash
pixi --version
```

## Core Concepts

### 1. Project Structure

Pixi uses a `pixi.toml` file (similar to `package.json` or `environment.yaml`) that defines:
- Project metadata
- Dependencies (conda packages)
- Tasks (scripts/commands)
- Channels (package sources)

### 2. Environment Management

Unlike conda, pixi creates environments **per project** automatically:
- Environment location: `.pixi/env/` (in your project directory)
- No need to manually create/activate environments
- Each project is isolated

### 3. Workspaces

A **workspace** is a way to manage multiple related projects together. Think of it as a monorepo structure where:

- **Root `pixi.toml`**: Defines `[workspace]` section with shared configuration
  - Common channels (package repositories)
  - Shared features (like linting tools)
  - Workspace-wide settings
  
- **Subproject `pixi.toml`**: Each subproject has its own `[project]` section
  - Inherits workspace configuration
  - Can override channels if needed
  - Defines project-specific dependencies and tasks

**Benefits:**
- **Shared configuration**: Define channels once, use everywhere
- **Consistent tooling**: Share linting tools across projects
- **Isolated dependencies**: Each project manages its own dependencies
- **Scalability**: Easy to add new subprojects

**Example Structure:**
```
project-root/
├── pixi.toml              # Workspace root ([workspace])
└── backend/
    └── pixi.toml          # Backend project ([project])
```

**Usage:**
```bash
# From root - installs workspace (if it has dependencies)
pixi install

# From subproject - installs that project (inherits workspace config)
cd backend
pixi install
```

### 4. Features and Linting

**Features** are optional groups of dependencies and tasks that you can include when installing:

```toml
[feature.lint.dependencies]
ruff = "*"        # Python linter
mypy = "*"        # Type checker
pre-commit = "*"  # Git hooks
```

**What is Linting?**

**Linting** is automated code quality checking. Linters analyze your code to find:
- **Style issues**: Formatting, naming conventions
- **Potential bugs**: Logic errors, unused variables
- **Security vulnerabilities**: Unsafe code patterns
- **Type errors**: Type mismatches
- **Best practices**: Code quality improvements

**Common Linting Tools:**

| Tool | Purpose |
|------|---------|
| **ruff** | Fast Python linter (style, imports, errors) |
| **mypy** | Static type checker for Python |
| **bandit** | Security vulnerability scanner |
| **pre-commit** | Runs checks automatically before git commits |
| **prettier** | Code formatter (multiple languages) |
| **typos** | Spell checker for code |
| **shellcheck** | Shell script linter |
| **taplo** | TOML file linter/formatter |

**Using Features:**

```bash
# Install with a specific feature
pixi install --feature lint

# Install with multiple features
pixi install --feature prod --feature dev

# Use features in environments (defined in pixi.toml)
pixi install --environment default  # Uses features defined in [environments]
```

**Why Use Features?**

- **Smaller environments**: Only install what you need
- **Flexible development**: Add tools when needed
- **Production optimization**: Skip dev tools in production
- **Clear organization**: Group related dependencies

### 5. Basic Commands

```bash
# Initialize a new pixi project (ONLY if starting from scratch - NOT needed for this project!)
# pixi init  # Skip this - pixi.toml already exists!

# Install all dependencies (start here!)
pixi install

# Run a command in the pixi environment
pixi run <command>

# Add a dependency
pixi add <package>

# Add a development dependency
pixi add --dev <package>

# Add a pip package
pixi add --pypi <package>

# Remove a dependency
pixi remove <package>

# Update dependencies
pixi update

# Run a task (defined in pixi.toml)
pixi task <task-name>

# Clean the environment
pixi clean

# Show environment info
pixi info
```

## Migration from Conda

### What Changed

1. **Environment file**: `environment.yaml` → `pixi.toml`
2. **Activation**: No need to `conda activate` - pixi auto-activates
3. **Installation**: `conda install` → `pixi add`
4. **Pip packages**: Can be added with `pixi add --pypi <package>`

### Key Differences

| Conda/Mamba | Pixi |
|-------------|------|
| `conda env create -f environment.yaml` | `pixi install` |
| `conda activate env_name` | Auto-activated (or `pixi shell`) |
| `conda install package` | `pixi add package` |
| `pip install package` | `pixi add --pypi package` |
| Global environments | Project-scoped environments |
