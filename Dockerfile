pipeline {
   agent any
   environment
   {
       registry = "alekyadock/docker-pipe"
       registryCredential = 'dockerhub'
       dockerImage = ''
   }
   
   stages {
     stage('checkout') {
          steps {
           
               git branch: 'master', url: 'https://github.com/madhavi0891/Dockerfiles.git'
           
         }
       }
     stage('Image Build'){
          steps{
              script{
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }
     stage('Deploy our image') {
         steps{
           script {
             docker.withRegistry( '', registryCredential ) {
             dockerImage.push()
           }
       }
           }
       }

}
}
