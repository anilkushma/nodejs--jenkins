pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "ramboo2023/nodejs-app"
        KUBERNETES_DEPLOYMENT = "nodejs-app-deployment"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/anilkushma/nodejs--jenkins.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def app = docker.build("${DOCKER_IMAGE}:${env.BUILD_ID}")
                    // Optionally, you can also tag with a specific version or latest
                    docker.tag("${DOCKER_IMAGE}:${env.BUILD_ID}", "${DOCKER_IMAGE}:latest")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-credentials') {
                        // Push specific build ID tag
                        docker.image("${DOCKER_IMAGE}:${env.BUILD_ID}").push()
                        // Push latest tag
                        docker.image("${DOCKER_IMAGE}:latest").push()
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    kubernetesDeploy(
                        configs: 'k8s/deployment.yaml',
                        kubeconfigId: 'kubeconfig-credentials',
                        enableConfigSubstitution: true
                    )
                }
            }
        }
    }
}
