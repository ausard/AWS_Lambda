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
                git branch: 'task5', url: 'https://github.com/ausard/Modules'
            }          
        }
        stage("Gradle build"){
            steps{
                sh './gradlew incrementVersion'
                sh './gradlew clean build'
                archiveArtifacts 'build/libs/app.war'
            }          
        }        
    }
    post{
        success{  
          echo "Open your browser at http://localhost:8081/"
        }
    }      
} 