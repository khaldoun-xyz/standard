# Architectural paradigms

## AI end-user product

- Deploy the application using docker-compose.yml, which deploys three
  Docker containers: Frontend (React) + Backend (FastAPI) + NGINX
- Use Pixi for dependency management locally & inside
  the Docker containers, run basic pre-commit hooks
- Certify SSL using `sudo certbot certonly --standalone -d URL`
  on the server, mount the SSL certificates in nginx.conf
- Add Python backend tests to a `/tests` folder outside the `/src` folder,
  run a GitHub Action that runs these tests
  when a commit is pushed to GitHub
- Add a GitHub Action that automatically deploys
  a master merge to production

