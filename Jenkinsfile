pipeline {
    agent any

    environment {
        TERRAFORM_PATH = '"C:\\Program Files\\terraform\\terraform.exe"'
        DOCKER_IMAGE   = "dhanalakshmi16/tomcat-app:latest"
    }

    stages {

        stage('Terraform Init') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']]) {
                    bat "${env.TERRAFORM_PATH} init"
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']]) {
                    bat "${env.TERRAFORM_PATH} apply -auto-approve"
                }
            }
        }

        stage('Show EC2 Public URL') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']]) {
                    script {
                        def ip = bat(script: "${env.TERRAFORM_PATH} output -raw public_ip", returnStdout: true).trim()
                        echo "Your Tomcat app is live at: http://${ip}:8080/sample/"
                    }
                }
            }
        }

    }

    post {
        success {
            echo "Pipeline completed successfully! Your app URL is above."
        }
        failure {
            echo "Pipeline failed! Check AWS credentials and security group."
        }
    }
}

