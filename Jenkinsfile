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
                archiveArtifacts 'HelloWorldFunction/build/libs/HelloWorldFunction.jar'
            }          
        }        
        stage("first"){
            steps{
                echo 'hi'
            }                      
        }
    }
    post{
        success{  
          echo "Open your browser at http://localhost:8081/"
        }
    }      
} 