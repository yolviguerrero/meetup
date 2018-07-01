pipeline {
  agent any
  environment {
    ARTIFACTOR = "${env.BUILD_NUMBER}.zip"
  }
  
  stages {
    stage("Repository") {
      steps {
          checkout scm
      }
    }
    stage("Build") {
      steps {
        sh "zip -r ${ARTIFACTOR} meetup/"
	//sh "docker build -t myimage:${env.BUILD_NUMBER} ."
	//sh "docker tag myimage:${env.BUILD_NUMBER} myimage:latest"

	sh "echo \"BUILD_NUMBER=${env.BUILD_NUMBER}\" > .env"
        sh "docker-compose build"
        sh "docker tag myimage:${env.BUILD_NUMBER} myimage:latest"
      }
    }
    stage("Test") {
      steps {
        parallel (
          syntax: { sh "echo syntax" },
          grep: { sh "echo 'grep'" }
        )
      }
    }
   

  stage("Deploy") {
      steps {
          sh "docker stack deploy --compose-file docker-stack.yml meetup"
      }
    }
}
  post {
    always {
      archiveArtifacts artifacts: "${ARTIFACTOR}", onlyIfSuccessful: true
      sh "rm -f ${ARTIFACTOR}"
      echo "Job has finished"
    }
  }
}

