pipeline {
    agent any
    
    stages {
        stage('Pulling code form git') {
            steps {
                sh "terraform -v"
                sh "ls "
            }
        }
        
        stage('terraform initialization and planning') {
            steps {
                dir('dev') {
                    /* execute commands in the scripts directory */
                    sh "terraform init"
                    sh "terraform plan "
                }
            }
        }
    }
}
