@Library("Shared") _
pipeline {
    agent any

    stages {
        stage('git clone') {
            steps {
                echo 'git clone'
                git branch: 'main', url: 'https://github.com/ganeshkhairedevops/taskmaster.git'
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
post{
        success{
            script{
                emailext from: 'ganeshkhaire14@gmail.com',
                to: 'ganeshkhaire14@gmail.com',
                body: 'Build success for Demo CICD App',
                subject: 'Build success for Demo CICD App'
            }
        }
        failure{
            script{
                emailext from: 'ganeshkhaire14@gmail.com',
                to: 'ganeshkhaire14@gmail.com',
                body: 'Build Failed for Demo CICD App',
                subject: 'Build Failed for Demo CICD App'
            }
        }
    }
}
