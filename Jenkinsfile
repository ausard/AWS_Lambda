#!groovy
pipeline { 
   agent any   
   options{
      timestamps()
   }
//    parameters {
//        extendedChoice bindings: '', defaultValue: '9', description: 'Image version : ', groovyClasspath: '', groovyScriptFile: '/vagrant/groovy.script', multiSelectDelimiter: ',', name: 'VERSION', quoteValue: false, saveJSONParameterToFile: false, type: 'PT_SINGLE_SELECT', visibleItemCount: 5
//    } 
    parameters {
        booleanParam defaultValue: false, description: 'Building App with Libs', name: 'BuildWithLibs'
    } 
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
        }
        stage("Build and Deploy the application"){            
            steps{
                 withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {                                        
                    sh 'export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID'
                    sh 'export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY'
                    script{
                        if ( params.BuildWithLibs ) {
                            dir ("HelloWorldFunctionLibs"){
                                sh './gradlew clean build'
                            }
                            sh '/usr/local/bin/sam package --template-file template_with_lib.yml --output-template-file packaged.yml --s3-bucket sam-deployment-bucket-ausard'
	                        sh '/usr/local/bin/sam deploy --template-file packaged.yml'                    
                        }
                        if !( params.BuildWithLibs ){
                            sh '/usr/local/bin/sam build'
                            sh '/usr/local/bin/sam deploy'                    
                        }
                    }                  
                }
            }
        }                
    }    
} 