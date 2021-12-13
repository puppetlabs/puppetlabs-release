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
    matrix {
      axes {
        axis {
          name 'PLATFORM'
          values 'debian-10-amd64', 'debian-11-amd64', 'debian-9-amd64', 'el-6-x86_64,el-7-x86_64',
          'el-8-aarch64,el-8-x86_64', 'fedora-32-x86_64', 'fedora-34-x86_64', 'sles-11-x86_64', 
          'sles-12-ppc64le', 'sles-12-x86_64', 'sles-15-x86_64', 'ubuntu-14.04-amd64', 'ubuntu-16.04-amd64',
          'ubuntu-18.04-amd64', 'ubuntu-20.04-amd64'
        }
        axis {
          name 'PROJECT'
          values 'puppet-nightly-release', 'puppet-release', 'puppet-tools-release', 'puppet5-nightly-release',
          'puppet5-release', 'puppet6-nightly-release', 'puppet6-release', 'puppet7-nightly-release',
          'puppet7-release', 'release-puppet-nightly', 'release-puppet-stable', 'release-puppet6-nightly',
          'release-puppet6-stable', 'release-puppet7-nightly', 'release-puppet7-stable'
        }
      }
    stage('Build') {
      steps {
        sh "./ci/vanagon_build $PROJECT $PLATFORM"
      }
    }
  }
  post {
    always {
      archiveArtifacts artifacts: 'output/**/*'
    }
  }
}
