pipeline {
    agent {
        docker {
            // Use the Docker image with the tools needed for your build
            image 'node:17-alpine'
            // Mount the Docker socket so Docker commands can be executed within the container
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }
    
    stages {
        stage('Checkout') {
            steps {
                // Check out the code from your Git repository
                git 'https://github.com/KurtCloudZa/Docker-React.git'
            }
        }
        
        stage('Build') {
            steps {
                // Build your application (e.g., using npm or any other build tool)
                sh 'npm install'
                sh 'npm run build'
            }
        }
        
        stage('Deploy') {
            steps {
                // Build and run your Docker container
                script {
                    docker.build('kurtcloudza/docker-react-snap:latest', '.')
                    docker.image('kurtcloudza/docker-react-snap:latest').run('-p 8081:80')
                }
            }
        }
    }
}
