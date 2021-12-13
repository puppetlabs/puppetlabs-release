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
    stage('BuildArtifacts') {
      matrix {
        axes {
          axis {
            name 'PLATFORM'
            values 'debian-10-amd64', 'debian-11-amd64', 'debian-9-amd64', 'el-6-x86_64,el-7-x86_64',
            'el-8-aarch64,el-8-x86_64'
          }
          axis {
            name 'PROJECT'
            values 'puppet-nightly-release', 'puppet-release', 'puppet-tools-release', 'puppet5-nightly-release',
            'puppet5-release'
          }
        }
        stages {
          stage('Build') {
            steps {
              sh "./ci/vanagon_build"
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