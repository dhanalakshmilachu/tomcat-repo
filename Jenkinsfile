pipeline {
    agent any

    environment {
        TERRAFORM_PATH = '"C:\\Program Files\\terraform\\terraform.exe"'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/dhanalakshmilachu/tomcat-repo.git'
            }
        }

        stage('Terraform Init') {
            steps {
                bat "${TERRAFORM_PATH} init"
            }
        }

        stage('Terraform Apply') {
            steps {
                bat "${TERRAFORM_PATH} apply -auto-approve"
            }
        }

        stage('Show EC2 Public URL') {
            steps {
                script {
                    def ip = bat(script: "${TERRAFORM_PATH} output -raw public_ip", returnStdout: true).trim()
                    echo "Tomcat sample app is live at: http://${ip}:8080/"
                }
            }
        }
    }
}

