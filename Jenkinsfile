pipeline {
    agent any

    tools { nodejs "node" }

    stages{
        stage{
            steps{
                git 'https://github.com/KurtCloudZa/Docker-React.git'
            }
        }

        stage('Build') {
            steps {
                sh 'npm install'
            }
        }

        stage("Tests"){
            steps{
                sh 'npm test'
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

        stage('Echo Docker Host IP') {
            steps {
                script {
                    // Run a shell command to get the Docker host IP address
                    sh "echo Docker host IP address: \$(hostname -I | awk '{print \$1}')"
                }
            }
        }
    }
}
