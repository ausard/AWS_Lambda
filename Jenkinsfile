#!groovy
pipeline { 
   agent any   
   options{
      timestamps()
   }
//    parameters {
//        extendedChoice bindings: '', defaultValue: '9', description: 'Image version : ', groovyClasspath: '', groovyScriptFile: '/vagrant/groovy.script', multiSelectDelimiter: ',', name: 'VERSION', quoteValue: false, saveJSONParameterToFile: false, type: 'PT_SINGLE_SELECT', visibleItemCount: 5
//    }  
    stages {       
        stage("Prepare Ws"){
            steps{
                cleanWs()                
                sh 'pip install --upgrade pip'
                sh 'pip install pipenv --user'
                sh 'pipenv install awscli aws-sam-cli'

            }          
        }
        stage("Git clone"){
            steps{
                git 'https://github.com/ausard/AWS_Lambda.git'
            }          
        }
                
        stage("Gradle build"){
            steps{
                dir("HelloWorldFunction"){
                    sh './gradlew clean build'                    
                }
            }
            post{
                success{                   
                        // samDeploy([
                        // credentialsId: 'aws',
                        // outputTemplateFile: 'template-output.yml',
                        // region: 'eu-central-1',
                        // s3Bucket: 'sam-deployment-bucket-ausard',
                        // stackName: 'HelloSAMApp',
                        // templateFile: 'template.yml'])                                     
                //    sh 'aws s3 mb s3://sam-deployment-bucket-ausard'
                sh 'pipenv run sam build'
                sh 'pipenv run sam deploy'
                }
            }                     
        }                
    }
    post{
        success{  
          echo "Open your browser at http://localhost:8081/"
        }
    }      
} 