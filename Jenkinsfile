pipeline {
  agent  {
    label 'k8s-worker'
  }
  options {
    timestamps()
    ansiColor('xterm')
  }
  environment {
    ARTIFACTORY_API_KEY = credentials('api_token_for_jenkins_to_artifactory')
  }
  stages {
    stage('Build') {
      steps {
        cleanWs()
        sh "mkdir output"
        sh "echo 'hello' >> output/hello.txt"
      }
    }
    post {
      always {
        archiveArtifacts artifacts: 'output/*'
      }
    }
  }
}