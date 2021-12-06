pipeline {
  agent  {
    label 'k8s-worker'
  }

  options {
    timestamps()
    ansiColor('xterm')
    preserveStashes(buildCount: 15)
  }

  environment {
    ARTIFACTORY_API_KEY = credentials('api_token_for_jenkins_to_artifactory')
  }

  triggers {
    githubPush()
  }
  stages {
    stage('Build') {
      steps {
        sh "chmod +x -R ${env.WORKSPACE}"
        sh "./ci/vanagon_build.sh"
      }
    }
  }
  post {
    always {
      archiveArtifacts artifacts: 'output/*'
    }
  }
}