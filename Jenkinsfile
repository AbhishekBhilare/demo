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
    
    parameters {
        string(name: 'WORKSPACE', defaultValue: 'development', description:'setting up workspace for terraform')
    }
//     environment {
//          TF_HOME = tool('terraform')
//       TP_LOG = "WARN"
//          PATH = "$TF_HOME:$PATH"
//     }
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
                    sh "terraform fmt -list=true -write=false -diff=true -check=true"
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
                        try {
                            sh "terraform workspace new ${params.WORKSPACE}"
                        } catch (err) {
                            sh "terraform workspace select ${params.WORKSPACE}"
                        }
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
                        input message: 'Can you please confirm the apply', ok: 'Ready to Apply the Config'
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
    }
}
