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

                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {                                        
                    sh 'export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID'
                    sh 'export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY'
                    sh '/usr/local/bin/aws s3api create-bucket --bucket sam-deployment-bucket-ausard --region eu-central-1' 
                    sh '/usr/local/bin/sam build'
                    sh '/usr/local/bin/sam deploy'
                }
                
                }
            }                     
        }                
    }    
} 