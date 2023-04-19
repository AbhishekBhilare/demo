// pipeline {
//     agent any
    
//     stages {
//         stage('Pulling code form git') {
//             steps {
//                 sh "terraform -v"
//                 sh "ls "
//             }
//         }
        
//         stage('terraform initialization and planning') {
//             steps {
//                 dir('dev') {
//                     /* execute commands in the scripts directory */
//                     sh "terraform init"
//                     sh "terraform plan "
//                 }
//             }
//         }
//     }
// }
pipeline {
    agent any
    

    stages {
            stage('TerraformInit'){
            steps {
                dir('dev'){
                    sh "terraform init -input=false"
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
                            sh 'terraform destroy ' 
                        }
                    }
                }
            }
        }
    }
}
