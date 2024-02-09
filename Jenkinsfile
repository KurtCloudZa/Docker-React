pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'docker-react-snap'
        CONTAINER_NAME = 'react-app-container'
        PORT = '8082'
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
                    docker.image(env.DOCKER_IMAGE).run([
                        "-p", "${env.PORT}:${env.PORT}",
                        "--name", "${env.CONTAINER_NAME}",
                        "-d"
                    ])
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
