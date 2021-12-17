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

  stages {
    stage('BuildArtifacts') {
      matrix {
        axes {
          axis {
            name 'PROJECT'
            values 'puppet-nightly-release', 'puppet-release', 'puppet-tools-release',
            'puppet6-nightly-release', 'puppet6-release', 'puppet7-nightly-release',
            'puppet7-release', 'release-puppet-nightly', 'release-puppet-stable', 'release-puppet6-nightly', 
            'release-puppet6-stable', 'release-puppet7-nightly', 'release-puppet7-stable'
          }
        }
        stages {
          stage('Build') {
            steps {
              script {
                sh "./ci/vanagon_build_project"
              }
            }
          }
        }
      }
    }
  }

  post {
    always {
      archiveArtifacts artifacts: 'output/**/*'
    }
  }
}
