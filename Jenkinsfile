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
	stage("docker push"){
            steps{
                withCredentials([usernamePassword(
                    credentialsId:"dockerHubCreds",
                    passwordVariable: "dockerHubPass",
                    usernameVariable: "dockerHubUser"
                 )]){
                sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPass}"
                sh "docker tag shoping ${env.dockerHubUser}/shoping"
                sh "docker push ${env.dockerHubUser}/shoping:latest"
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
}

