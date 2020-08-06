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
        stage("Clean Ws"){
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
                        // credentialsId: 'AWS',
                        // outputTemplateFile: 'template-output.yml',
                        // region: 'eu-central-1',
                        // s3Bucket: 'sam-deployment-bucket-ausard',
                        // stackName: 'HelloSAMApp',
                        // templateFile: 'HelloWorldFunction/template.yml'])                                     
                   sh 'make sam'
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