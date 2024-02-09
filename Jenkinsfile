pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'docker-react-snap'
        CONTAINER_NAME = 'react-app-container'
        PORT = '8082'
        SSH_PORT = '22'
        SSH_USER = 'root' // Change this to your SSH username
        DOCKER_HOST = 'localhost' // Change this to your Docker host IP or hostname
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the Git repository
                git branch: 'main', url: 'https://github.com/KurtCloudZa/Docker-React.git'
            }
        }
        stage('Build and Run Docker Container') {
            steps {
                // Build Docker image
                script {
                    docker.build(env.DOCKER_IMAGE)
                }
                // Run Docker container
                script {
                    def dockerCmd = "docker run -d -p ${env.PORT}:${env.PORT} -p ${env.SSH_PORT}:22 --name ${env.CONTAINER_NAME} ${env.DOCKER_IMAGE}"
                    dockerCmd.execute().text
                    // Print SSH details
                    echo "To SSH into the container, use: ssh -p ${env.SSH_PORT} ${env.SSH_USER}@${env.DOCKER_HOST}"
                }
            }
        }
        stage('Cleanup') {
            steps {
                // Clean up Docker containers
                script {
                    docker.container(env.CONTAINER_NAME).stop()
                    docker.container(env.CONTAINER_NAME).remove(force: true)
                }
            }
        }
    }
}
