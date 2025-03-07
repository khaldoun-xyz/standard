# Automated Feature Branch Deployment Strategy Overview
The solution involves setting up a GitHub Actions workflow that automatically deploys code from feature branches to the test droplet whenever commits are pushed. This approach ensures continuous deployment of features for testing without manual intervention.
Implementation Details

1. Server Configuration Setup
First, the test droplet needs to be properly configured to handle multiple deployments:
 - SSH into the test droplet
  ssh root@165.22.78.207
 
 - Install required packages if not already installed
  apt update
  apt install -y python3-pip python3-venv nginx supervisor

 - Create deployments directory
  mkdir -p /var/www/deployments

 - Configure Nginx for wildcard subdomains
cat > /etc/nginx/sites-available/wildcard.conf << 'EOL'
server {
    listen 80 default_server;
    server_name *.test.lugha.app;
    
    location / {
        return 404 "No deployment found for this subdomain";
    }
}
EOL

ln -sf /etc/nginx/sites-available/wildcard.conf /etc/nginx/sites-enabled/
nginx -t && systemctl reload nginx

2. DNS Configuration
Configure DNS to point all subdomains of test.lugha.app to the test droplet:
Add a wildcard DNS A record: *.test.lugha.app → 165.22.78.207
This allows each feature branch to get its own subdomain automatically

3. GitHub Repository Configuration
Create a GitHub Actions Workflow File
Create a  file deploy-feature.yml


name: Feature Branch Deployment

on:
  push:
    branches:
      - 'feature/**'
      - 'feature-*'

jobs:
  test-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.10'

      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install -r requirements.txt
          pip install gunicorn
 
      - name: Configure SSH
        run: |
          mkdir -p ~/.ssh/
          echo "${{ secrets.SSH_PRIVATE_KEY }}" > ~/.ssh/id_rsa
          chmod 600 ~/.ssh/id_rsa
          ssh-keyscan -H 165.22.78.207 >> ~/.ssh/known_hosts

      - name: Generate deployment configuration
        run: |
          # Extract branch name for use in deployment
          BRANCH_NAME=${GITHUB_REF#refs/heads/}
          DEPLOYMENT_PATH="/var/www/deployments/${BRANCH_NAME//\//_}"
          
          # Generate unique port number based on branch name hash
          PORT_BASE=8000
          HASH_VALUE=$(echo $BRANCH_NAME | md5sum | awk '{print $1}')
          NUMERIC_HASH=$(echo "ibase=16; ${HASH_VALUE:0:4}" | bc)
          PORT=$((PORT_BASE + (NUMERIC_HASH % 1000)))
          
          # Create deployment config
          echo "DEPLOYMENT_PATH=$DEPLOYMENT_PATH" >> $GITHUB_ENV
          echo "PORT=$PORT" >> $GITHUB_ENV
          echo "BRANCH_NAME=$BRANCH_NAME" >> $GITHUB_ENV
          
          # Create .env file for the deployment
          cat > .env << EOL
          GROQ_API_KEY=${{ secrets.GROQ_API_KEY }}
          MODEL=llama3-70b-8192
          POSTGRES_HOST=" "
          POSTGRES_USER=lugha_test
          POSTGRES_PASSWORD=${{ secrets.POSTGRES_PASSWORD }}
          POSTGRES_DB=lugha_test
          PORT=$PORT
          EOL

      - name: Deploy to test server
        run: |
          ssh root@165.22.78.207 "mkdir -p ${{ env.DEPLOYMENT_PATH }}"
          rsync -avz --delete --exclude '.git/' --exclude 'venv/' --exclude '__pycache__/' ./ root@165.22.78.207:${{ env.DEPLOYMENT_PATH }}/
          
          # Create systemd service file for this deployment
          cat > ${BRANCH_NAME}.service << EOL
          [Unit]
          Description=Flask Application - ${{ env.BRANCH_NAME }}
          After=network.target

          [Service]
          User=www-data
          WorkingDirectory=${{ env.DEPLOYMENT_PATH }}
          ExecStart=/usr/bin/python3 -m gunicorn --workers 2 --bind 0.0.0.0:${{ env.PORT }} app:app
          Restart=always
          Environment="GROQ_API_KEY=${{ secrets.GROQ_API_KEY }}"
          Environment="MODEL=llama3-70b-8192"
          Environment="POSTGRES_HOST=db-postgresql-fra1-04446-do-user-7951242-0.a.db.ondigitalocean.com"
          Environment="POSTGRES_USER=lugha_test"
          Environment="POSTGRES_PASSWORD=${{ secrets.POSTGRES_PASSWORD }}"
          Environment="POSTGRES_DB=lugha_test"

          [Install]
          WantedBy=multi-user.target
          EOL
          
          # Copy and enable the service
          scp ${BRANCH_NAME}.service root@165.22.78.207:/etc/systemd/system/flask-${{ env.BRANCH_NAME }}.service
          ssh root@165.22.78.207 "systemctl daemon-reload && systemctl enable flask-${{ env.BRANCH_NAME }} && systemctl restart flask-${{ env.BRANCH_NAME }}"
          
          # Update Nginx configuration to route to this deployment
          ssh root@165.22.78.207 "cat > /etc/nginx/sites-available/${{ env.BRANCH_NAME }}.conf << 'EOL'
          server {
              listen 80;
              server_name ${{ env.BRANCH_NAME }}.test.lugha.app;
              
              location / {
                  proxy_pass http://localhost:${{ env.PORT }};
                  proxy_set_header Host \$host;
                  proxy_set_header X-Real-IP \$remote_addr;
                  proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
                  proxy_set_header X-Forwarded-Proto \$scheme;
              }
          }
          EOL"
          
          ssh root@165.22.78.207 "ln -sf /etc/nginx/sites-available/${{ env.BRANCH_NAME }}.conf /etc/nginx/sites-enabled/ && nginx -t && systemctl reload nginx"

      - name: Output deployment URL
        run: |
          echo "::notice::Deployment successful! Your branch is now accessible at http://${{ env.BRANCH_NAME }}.test.lugha.app"


4. GitHub Repository Configuration
Add the necessary secrets to the GitHub repository:
Go to Settings → Secrets and variables → Actions
Add the following secrets:
SSH_PRIVATE_KEY: Private SSH key for accessing the test droplet
GROQ_API_KEY: The API key from the .env file
POSTGRES_PASSWORD: Database password 

5. Access Control & Cleanup
Workflow Logic Explained
The GitHub Actions workflow operates as follows:
Branch Detection: Triggers only on pushes to branches that start with feature/ or feature-
Environment Setup: Installs Python and dependencies
Unique Deployment Configuration:
Each branch gets a unique subdirectory on the server
Each deployment runs on a unique port (calculated from branch name)
Each branch gets its own subdomain (e.g., feature-login.test.lugha.app)
Systemd Service Creation: Creates a dedicated service for each branch deployment
Nginx Configuration: Sets up a virtual host for each branch
6. Access Control & Cleanup
To manage the deployed branches, we can add additional workflows:
name: Clean Up Closed Branch Deployments

on:
  delete:
    branches:
      - 'feature/**'
      - 'feature-*'

jobs:
  cleanup:
    runs-on: ubuntu-latest
    steps:
      - name: Configure SSH
        run: |
          mkdir -p ~/.ssh/
          echo "${{ secrets.SSH_PRIVATE_KEY }}" > ~/.ssh/id_rsa
          chmod 600 ~/.ssh/id_rsa
          ssh-keyscan -H 165.22.78.207 >> ~/.ssh/known_hosts

      - name: Clean up deployment
        run: |
          # Extract branch name from the event payload
          BRANCH_NAME="${{ github.event.ref }}"
          DEPLOYMENT_PATH="/var/www/deployments/${BRANCH_NAME//\//_}"
          
          # Stop and remove systemd service
          ssh root@165.22.78.207 "systemctl stop flask-${BRANCH_NAME} || true"
          ssh root@165.22.78.207 "systemctl disable flask-${BRANCH_NAME} || true"
          ssh root@165.22.78.207 "rm -f /etc/systemd/system/flask-${BRANCH_NAME}.service"
          ssh root@165.22.78.207 "systemctl daemon-reload"
          
          # Remove Nginx configuration
          ssh root@165.22.78.207 "rm -f /etc/nginx/sites-enabled/${BRANCH_NAME}.conf"
          ssh root@165.22.78.207 "rm -f /etc/nginx/sites-available/${BRANCH_NAME}.conf"
          ssh root@165.22.78.207 "nginx -t && systemctl reload nginx"
          
          # Remove deployment directory
          ssh root@165.22.78.207 "rm -rf ${DEPLOYMENT_PATH}"
          
          echo "::notice::Deployment for branch ${BRANCH_NAME} has been cleaned up"



## Database Management Strategy
Since all feature branches use the same test database:
Schema Management: Each feature should use a schema prefix matching its branch name to avoid conflicts
Database Initialization: Add a step to the workflow to apply migrations or initialize the database for each branch
 - Example of branch-specific database initialization
branch_name = os.getenv('BRANCH_NAME').replace('-', '_').replace('/', '_')
schema_name = f"{branch_name}_schema"

 - Initialize database with branch-specific schema
def init_db():
    with db.connect() as conn:
        conn.execute(f"CREATE SCHEMA IF NOT EXISTS {schema_name}")
        conn.execute(f"SET search_path TO {schema_name}")
        # Run migrations or table creation scripts

## Monitoring and Debugging
Add additional tools to help with monitoring deployed feature branches:
Deployment Dashboard: Create a simple Flask app running on the test server that shows all active branch deployments
Logging: Configure centralized logging for all deployments
from flask import Flask, render_template
import os
import subprocess
import json

app = Flask(__name__)

@app.route('/')
def dashboard():
    # Get all active services
    result = subprocess.run(
        "systemctl list-units --type=service --state=active | grep flask-feature | awk '{print $1}'",
        shell=True, capture_output=True, text=True
    )
    services = result.stdout.strip().split('\n')
    
    deployments = []
    for service in services:
        if not service:
            continue
        
        # Extract branch name from service name
        branch_name = service.replace('flask-', '')
        
        # Get service status
        status_result = subprocess.run(
            f"systemctl status {service} | grep Active",
            shell=True, capture_output=True, text=True
        )
        status = status_result.stdout.strip() if status_result.stdout else "Unknown"
        
        deployments.append({
            'branch': branch_name,
            'url': f"http://{branch_name}.test.lugha.app",
            'status': status,
            'deployed_at': get_deployment_time(service)
        })
    
    return render_template('dashboard.html', deployments=deployments)

def get_deployment_time(service):
    result = subprocess.run(
        f"systemctl show {service} -p ActiveEnterTimestamp | cut -d= -f2",
        shell=True, capture_output=True, text=True
    )
    return result.stdout.strip()

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8888)


## Benefits of This Approach
Isolation: Each feature branch gets its own isolated process and URL
Visibility: Stakeholders can easily access and test features by visiting the branch-specific URL
Automation: No manual deployment steps required when developers push changes
Resource Efficiency: All deployments share the same server, minimizing cloud costs
Cleanup: Automatic cleanup when feature branches are deleted

## Implementation Plan
- Set up the test droplet with the necessary base configuration
- Configure DNS for the wildcard subdomain
- Add the GitHub Actions workflow files to the repository
- Add required secrets to the GitHub repository
- Push to a feature branch to test the deployment
- Create the deployment dashboard for easy monitoring

By implementing this system, development speed will increase as every code change can be immediately tested in a production-like environment, without the overhead of manual deployments or complicated testing processes.
