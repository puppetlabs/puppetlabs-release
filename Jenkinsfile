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
        echo "Something has been committed"
      }
    }
  }
}