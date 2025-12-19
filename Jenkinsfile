pipeline {
    agent any

    environment {
        TERRAFORM_PATH = '"C:\\Program Files\\terraform\\terraform.exe"'
    }

    stages {

        stage('Checkout') {
            steps {
                // Pull code from your GitHub repo
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
                // Inject AWS credentials stored in Jenkins
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {
                    bat "${TERRAFORM_PATH} apply -auto-approve"
                }
            }
        }

        stage('Show EC2 Public URL') {
            steps {
                script {
                    // Get public IP of EC2 created by Terraform
                    def ip = bat(script: "${TERRAFORM_PATH} output -raw public_ip", returnStdout: true).trim()
                    echo "Tomcat sample app is live at: http://${ip}:8080/"
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully! EC2 is created and sample.war deployed."
        }
        failure {
            echo "Pipeline failed! Check AWS credentials, Terraform config, and security group."
        }
    }
}

