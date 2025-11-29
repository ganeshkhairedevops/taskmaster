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
        stage('deploy') {
            steps {
                echo 'deploy application'
                sh 'docker compose up -d --build'
            }
        }
    }
}

