node {
    // Define environment variables
    def AWS_REGION     = "us-east-1"
    def ECR_REPO       = "503561437388.dkr.ecr.us-east-1.amazonaws.com/node-ecs-app"
    def IMAGE_TAG      = "latest"
    def CLUSTER_NAME   = "my-ecs-cluster" // 🔹 Change to your ECS cluster name
    def SERVICE_NAME   = "node-ecs-service" // 🔹 Change to your ECS service name

    try {
        stage('Checkout') {
            echo "📥 Checking out source code from GitHub..."
            git branch: 'main', url: 'https://github.com/harsh2595/node-ecs-app.git'
        }

        stage('Login to ECR') {
            echo "🔑 Logging in to Amazon ECR..."
            withAWS(credentials: 'aws-creds', region: AWS_REGION) {
                sh """
                    aws ecr get-login-password --region ${AWS_REGION} \
                    | docker login --username AWS --password-stdin ${ECR_REPO}
                """
            }
        }

        stage('Build Docker Image') {
            echo "🐳 Building Docker image..."
            sh "docker build -t ${ECR_REPO}:${IMAGE_TAG} ."
        }

        stage('Push to ECR') {
            echo "📤 Pushing image to Amazon ECR..."
            sh "docker push ${ECR_REPO}:${IMAGE_TAG}"
        }

        stage('Deploy to ECS') {
            echo "🚀 Deploying new version to ECS..."
            withAWS(credentials: 'aws-creds', region: AWS_REGION) {
                sh """
                    aws ecs update-service \
                        --cluster ${CLUSTER_NAME} \
                        --service ${SERVICE_NAME} \
                        --force-new-deployment \
                        --region ${AWS_REGION}
                """
            }
        }

        // ✅ Success message
        echo "✅ Deployment completed successfully! ECS service '${SERVICE_NAME}' in cluster '${CLUSTER_NAME}' is now running the latest image."

    } catch (Exception e) {
        // ❌ Error handling
        echo "❌ Deployment failed: ${e.message}"
        currentBuild.result = 'FAILURE'
        throw e
    }
}
