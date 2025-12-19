pipeline {
    agent any

    environment {
        TERRAFORM_PATH = '"C:\\Program Files\\terraform\\terraform.exe"'
    }

    stages {

        stage('Checkout SCM') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/dhanalakshmilachu/tomcat-repo.git'
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {
                    bat "${env.TERRAFORM_PATH} init"
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {
                    bat "${env.TERRAFORM_PATH} plan"
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {
                    bat "${env.TERRAFORM_PATH} apply -auto-approve"
                }
            }
        }

        stage('Show EC2 Public IP') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {
                    script {
                        // Replace this command with how you output EC2 public IP
                        bat "${env.TERRAFORM_PATH} output public_ip"
                    }
                }
            }
        }

    }

    post {
        failure {
            echo "Pipeline failed! Check credentials and Terraform configuration."
        }
    }
}

