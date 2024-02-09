pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                // Check out the code from your Git repository
                git 'https://github.com/KurtCloudZa/Docker-React.git'
                echo 'Checkout Stage'
            }
        }
        
        stage('Build') {
            steps {
                // Build your application (e.g., using npm or any other build tool)
                sh 'npm install'
                sh 'npm run build'
                echo 'Build Stage'
            }
        }
        
        stage('Echo Docker Host IP') {
            steps {
                script {
                    // Run a shell command to get the Docker host IP address
                    sh "echo Docker host IP address: \$(hostname -I | awk '{print \$1}')"
                    echo 'IP Check Stage'
                }
            }
        }
        
        stage('Deploy') {
            steps {
                // Build and run your Docker container
                script {
                    docker.build('kurtcloudza/docker-react-snap:latest', '.')
                    docker.image('kurtcloudza/docker-react-snap:latest').run('-p 8081:80')
                    echo 'Deploy Stage'
                }
            }
        }
    }
}
