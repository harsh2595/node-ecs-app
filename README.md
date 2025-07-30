# Node ECS App 🚀

A simple Node.js + Express application with two routes (`/` and `/health`) that can be run locally, in Docker, and deployed to AWS ECS (Fargate).  
Perfect for testing ECS container deployments with health checks.

---

## 📌 Features
- **Home Route**: Returns a welcome message.
- **Health Check Route**: Returns service status (`UP`) for container health monitoring.
- **Dockerized**: Ready to run inside a container.
- **ECS Ready**: Can be deployed to AWS ECS with Application Load Balancer (ALB) health checks.

---

## 📂 Project Structure
node-ecs-app/
├── src/
│ └── index.js # Express app
├── package.json # Dependencies & scripts
├── Dockerfile # Docker build instructions
└── README.md # Project documentation

---

## ⚙️ Installation (Local Development)
1. Clone the repository:
```bash
git clone https://github.com/harsh2595/node-ecs-app.git
cd node-ecs-app
Install dependencies:

bash
Copy
Edit
npm install
Run the app:

bash
Copy
Edit
npm start
Open in browser:

Home: http://localhost:3000

Health: http://localhost:3000/health

🐳 Run with Docker
Build the Docker image:

bash
Copy
Edit
docker build -t node-ecs-app .
Run the container:

bash
Copy
Edit
docker run -p 3000:3000 node-ecs-app
Test in browser:

Home: http://localhost:3000

Health: http://localhost:3000/health

🚀 Deploy to AWS ECS (Fargate)
Push to Amazon ECR

bash
Copy
Edit
aws ecr create-repository --repository-name node-ecs-app
aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <AWS_ACCOUNT_ID>.dkr.ecr.<region>.amazonaws.com
docker tag node-ecs-app:latest <AWS_ACCOUNT_ID>.dkr.ecr.<region>.amazonaws.com/node-ecs-app:latest
docker push <AWS_ACCOUNT_ID>.dkr.ecr.<region>.amazonaws.com/node-ecs-app:latest
Create ECS Service

Launch type: Fargate

Port mapping: 3000

Attach Application Load Balancer

Target group health check path: /health

🔍 Health Check
Path: /health

Response:

json
Copy
Edit
{ "status": "UP" }
Used by ECS/ALB to determine if the container is healthy.
