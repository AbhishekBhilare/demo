pipeline {
    agent any
    

    stages {
            stage('TerraformInit'){
            steps {
                dir('dev'){
                    sh "ls -a"
                    sh "pwd"
                    sh "terraform init "
                }
            }
        }

        stage('TerraformFormat'){
            steps {
                dir('dev'){
                    sh "terraform fmt"
                }
            }
        }

        stage('TerraformValidate'){
            steps {
                dir('jenkins-terraform-pipeline/ec2_pipeline/'){
                    sh "terraform validate"
                }
            }
        }

        stage('TerraformPlan'){
            steps {
                dir('dev'){
                    script {
                        sh "terraform plan  \
                        -out terraform.tfplan;echo \$? > status"
                        stash name: "terraform-plan", includes: "terraform.tfplan"
                    }
                }
            }
        }
        
        stage('TerraformApply'){
            steps {
                script{
                    def apply = false
                    try {
                        echo "true"
                        input message: 'Can you please confirm the apply', ok: 'Ready to Apply the Config'
                        echo "button pressed"
                        apply = true
                    } catch (err) {
                        apply = false
                         currentBuild.result = 'UNSTABLE'
                    }
                    if(apply){
                        dir('dev'){
                            unstash "terraform-plan"
                            sh 'terraform apply terraform.tfplan' 
                        }
                    }
                }
            }
        }
            stage('TerraformDestroy'){
            steps {
                script{
                    def apply = false
                    try {
                        echo "true"
                        input message: 'Can you please confirm the apply', ok: 'Ready to Apply the Config'
                        echo "button pressed"
                        apply = true
                    } catch (err) {
                        apply = false
                         currentBuild.result = 'UNSTABLE'
                    }
                    if(apply){
                        dir('dev'){
                            sh 'terraform destroy -auto-approve ' 
                        }
                    }
                }
            }
        }
    }
}
