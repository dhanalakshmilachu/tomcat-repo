pipeline {
    agent any

    environment {
        TF = "C:\\Program Files\\terraform\\terraform.exe"
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                bat "\"%TF%\" init"
            }
        }

        stage('Terraform Apply') {
            steps {
                bat "\"%TF%\" apply -auto-approve"
            }
        }

        stage('Show EC2 Public IP') {
            steps {
                script {
                    def ip = bat(
                        script: "\"%TF%\" output -raw public_ip",
                        returnStdout: true
                    ).trim()

                    echo "================================"
                    echo "EC2 Public IP: ${ip}"
                    echo "URL: http://${ip}:8080/"
                    echo "================================"
                }
            }
        }
    }
}

