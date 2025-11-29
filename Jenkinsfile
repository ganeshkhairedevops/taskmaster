@Library("Shared") _
pipeline {
    agent any

    stages {
        stage('git clone') {
            steps {
                echo 'git clone'
                clone("https://github.com/ganeshkhairedevops/taskmaster.git", "main")
            }
        }

        stage('build') {
            steps {
                echo 'build image'
                sh 'docker build -t taskmaster .'
            }
        }

        stage('docker push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: "dockerHubCreds",
                    passwordVariable: "dockerHubPass",
                    usernameVariable: "dockerHubUser"
                )]) {
                    sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPass}"
                    sh "docker tag taskmaster ${env.dockerHubUser}/taskmaster"
                    sh "docker push ${env.dockerHubUser}/taskmaster:latest"
                }
            }
        }

        stage('deploy') {
            steps {
                echo 'deploy application'
                sh 'docker compose up -d --build'
            }
        }
    }
}  // <-- closing brace for pipeline
