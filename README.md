# 🚀 Node ECS App

A simple **Node.js + Express** application with two routes (`/` and `/health`) that can be run **locally**, inside **Docker**, and deployed to **AWS ECS (Fargate)**.  
This is perfect for testing **ECS container deployments** with **Application Load Balancer (ALB) health checks**.

---

## 📌 Features
- **Home Route (`/`)** → Returns a welcome message.
- **Health Check Route (`/health`)** → Returns `UP` for health monitoring.
- **Dockerized** → Ready to run inside a container.
- **ECS Ready** → Works with AWS ECS Fargate + ALB health checks.

---

## 📂 Project Structure
node-ecs-app/
├── src/
│ └── index.js # Express app code
├── package.json # Dependencies & scripts
├── Dockerfile # Docker build instructions
└── README.md # Documentation


---

## ⚙️ Local Development

### 1️⃣ Clone the repository
```bash
git clone https://github.com/harsh2595/node-ecs-app.git
cd node-ecs-app
2️⃣ Install dependencies
bash
Copy
Edit
npm install
3️⃣ Run the app
bash
Copy
Edit
npm start
4️⃣ Test in your browser
Home Route → http://localhost:3000

Health Route → http://localhost:3000/health

🐳 Run with Docker
1️⃣ Build the Docker image
bash
Copy
Edit
docker build -t node-ecs-app .
2️⃣ Run the container
bash
Copy
Edit
docker run -p 3000:3000 node-ecs-app
3️⃣ Test in your browser
Home Route → http://localhost:3000

Health Route → http://localhost:3000/health

🚀 Deploy to AWS ECS (Fargate)
1️⃣ Push Image to Amazon ECR
bash
Copy
Edit
# Create ECR repository
aws ecr create-repository --repository-name node-ecs-app

# Authenticate Docker to ECR
aws ecr get-login-password --region <region> \
| docker login --username AWS --password-stdin <AWS_ACCOUNT_ID>.dkr.ecr.<region>.amazonaws.com

# Tag image for ECR
docker tag node-ecs-app:latest <AWS_ACCOUNT_ID>.dkr.ecr.<region>.amazonaws.com/node-ecs-app:latest

# Push image
docker push <AWS_ACCOUNT_ID>.dkr.ecr.<region>.amazonaws.com/node-ecs-app:latest
2️⃣ Create ECS Service
Launch Type → Fargate

Port Mapping → 3000

Load Balancer → Application Load Balancer (ALB)

Target Group Health Check Path → /health

🔍 Health Check Details
Path: /health

Response:

json
Copy
Edit
{ "status": "UP" }
This is used by ECS/ALB to determine if the container is healthy.
