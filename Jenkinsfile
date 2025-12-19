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
                bat "\"%TF%\" init"
            }
        }

        stage('Terraform Plan') {
            steps {
                withEnv([
                    "AWS_ACCESS_KEY_ID=${credentials('aws-creds')}",         // AWS Access Key ID
                    "AWS_SECRET_ACCESS_KEY=${credentials('aws-secret-key')}" // AWS Secret Key
                ]) {
                    bat "\"%TF%\" plan"
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withEnv([
                    "AWS_ACCESS_KEY_ID=${credentials('aws-creds')}",
                    "AWS_SECRET_ACCESS_KEY=${credentials('aws-secret-key')}"
                ]) {
                    bat "\"%TF%\" apply -auto-approve"
                }
            }
        }

        stage('Show EC2 Public IP') {
            steps {
                bat "\"%TF%\" output"
            }
        }
    }
}

