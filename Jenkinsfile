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
    ABS_TOKEN = credentials('always-be-scheduling-k8s')
  }

  triggers {
    githubPush()
  }

  stages {
    stage('Build') {
      steps {
        sh "./ci/vanagon_build"
      }
    }
  }
  post {
    always {
      archiveArtifacts artifacts: 'output/*'
    }
  }
}