pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = "eu-north-1"
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
                withCredentials([
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]) {
                    bat "\"%TF%\" init"
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withCredentials([
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]) {
                    bat "\"%TF%\" apply -auto-approve"
                }
            }
        }

        stage('Show EC2 Public IP') {
            steps {
                script {
                    def ip = bat(
                        script: "\"%TF%\" output -raw public_ip",
                        returnStdout: true
                    ).trim()

                    echo "EC2 Public IP: ${ip}"
                    echo "URL: http://${ip}:8080/sample/"
                }
            }
        }
    }
}

