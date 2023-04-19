pipeline {
    agent any
    environment {
        // TF_HOME = tool('terraform')
        // TP_LOG = "WARN"
        // PATH = "$TF_HOME:$PATH"
        ACCESS_KEY = credentials('AWS_ACCESS_KEY_ID')
        SECRET_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    stages {
        stage('Pulling code form git') {
            steps {
                sh "terraform -v"
                sh "ls "
            }
        }
        
        stage('terraform initialization and planning') {
            steps {
                sh "terraform init"
                sh "terraform plan "
            }
        }
    }
}
