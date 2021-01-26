#! groovy

GITHUB_AUTHOR = "tarekabdallah"
GITHUB_ACCESS_TOKEN = "e41802ceeab163bafd69cd707f0a03dc123a707b"
GITHUB_REPO_NAME = "pixbay"
BUILD_CONSOLE_URL = "$BUILD_URL/console"

STATUS_PENDING = "pending"
STATUS_SUCCESS = "success"
STATUS_FAILURE = "failure"

STATUS_SUCCESS_DESCRIPTION = "The build succeeded"
STATUS_FAILURE_DESCRIPTION = "The build failed"
STATUS_ABORTED_DESCRIPTION = "The build was aborted"
STATUS_UNSTABLE_DESCRIPTION = "The build was unstable"

STAGE_SETUP_DESCRIPTION = "Setup.."
STAGE_BUILD_DESCRIPTION = "Building.."
STAGE_RELEASE_DESCRIPTION = "Releasing to the  AppStore.."

def updateBuildStatus(String status, String description = "Jenkins") {
}

pipeline {
    agent any
  triggers{
    bitbucketPush()
  }
    stages {
        stage('Setup') {
            steps {
                echo "$STAGE_SETUP_DESCRIPTION"
                updateBuildStatus("$STATUS_PENDING", "$STAGE_SETUP_DESCRIPTION")
                 sh "gem install bundler"
                 sh "bundle check --path=vendor/bundle || bundle install --path=vendor/bundle --jobs=4 --retry=3"
                 sh "bundle exec pod install"
            }
        }
        stage('Release') {
            when {
                tag "release/*"
            }
            steps {
                echo "$STAGE_RELEASE_DESCRIPTION"
                updateBuildStatus("$STATUS_PENDING", "$STAGE_RELEASE_DESCRIPTION")
                sh "fastlane release app_version:${TAG_NAME.drop(8)}    "
            }
        }
    }

    post {
        success {
            updateBuildStatus("$STATUS_SUCCESS", "$STATUS_SUCCESS_DESCRIPTION: $UPDATED_BUILD_NUMBER")
        }
        failure {
            updateBuildStatus("$STATUS_FAILURE", "$STATUS_FAILURE_DESCRIPTION")
        }
        aborted {
            updateBuildStatus("$STATUS_FAILURE", "$STATUS_ABORTED_DESCRIPTION")
        }
        unstable {
            updateBuildStatus("$STATUS_FAILURE", "$STATUS_UNSTABLE_DESCRIPTION")
        }
    }
}
