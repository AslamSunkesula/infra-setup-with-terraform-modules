pipeline  {
    
    environment {
        PROJECT = "Welcome To Jenkins-Terraform Modules pipeline"
        TERRAFORM_MODULES_REPRO = "https://github.com/AslamSunkesula/infra-setup-with-terraform-modules.git"
    }
    stages {
        stage('For Parellel Stages') {
            Parallel {
                stage('Deploy To Development') {
                    agent {label 'DEV'}
                    environment {
                        TERRAFORM_APPLY = "NO"
                        
                    }
                    when {
                        branch 'development'
                    }
                    stages
                    {
                      stage ('Clone Terraform Modules' ){
                        steps {
                            sh 'pwd'
                            sh 'rm -rf terrafrom-modules'
                            sh 'ls -al'
                            sh 'git clone ${TERRAFORM_MODULES_REPRO}'
                            sh 'ls -al terrafrom-modules/develpment'
                            sh 'find terrafrom-modules/development -name "*.tf"'

                        }
                      }
                      stage ('Terraform init & Plan') {

                        when {  
                        expression {
                            TERRAFORM_APPLY = "YES"
                        }
                            
                        steps {
                            sh 'pwd'
                            sh 'ls -al'
                            sh 'cd terrafrom-modulees/development'
                            sh 'terraform init'
                            sh 'terraform validate'
                        }
                      } 
                       stage {
                        when {
                             expression {
                            TERRAFORM_APPLY == "YES"
                        }}

                        steps {
                            dir('terraform-modules/development')
                            sh 'terraform apply -var-file=terraform.tfvars -auto-approve'
                        }
                       }

                    }
                }

                stage ('Terraform Destroy') {
                    agent {label 'DEV'}
                    when {
                        expression {
                            TERRAFORM_APPLY == "YES"
                        }

                        steps {
                            dir ('terraform-modules/development')
                            sh 'terrafrom init'
                            sh 'terraform validate'
                            sh 'terraform destroy -var-file=terraform.tfvars -auto-approve'
                        }  
                    }
                        
                }
            }
        }
    
    }
}

// stage ('Deploy To Production') {
//     agent {label 'PROD'}
//     environment  {
//         TERRAFORM_APPLY = "NO"
//     }
//     when {
//         branch 'master'
//     }


// }