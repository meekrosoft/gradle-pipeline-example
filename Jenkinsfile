pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh './gradlew clean'
                sh 'javac -version'
                echo 'Building..'
                sh './gradlew build'
            }
        }
        stage('Register artifact in ComplianceDB') {
            steps {
                echo 'Registering artifact in ComplianceDB...'
                sh 'ls build/libs'
                sh '''
                    ARTIFACT_SHA=$(openssl dgst -sha256 build/libs/gradle-site-plugin-0.6.jar | cut -d " " -f 2 -)
                    echo "Artifact SHA is $ARTIFACT_SHA"
                    echo ARTIFACT_SHA=$ARTIFACT_SHA > artifact.sha
                    ./create_artifact.sh cern hadroncollider $ARTIFACT_SHA gradle-site-plugin-0.6.jar "Created by build ${BUILD_NUMBER}"
                '''
                stash includes: 'build/libs/*', name: 'build'
            }
        }
        stage('Add Code Review information') {
            steps {
                echo 'Gathering code review information....'
                dir('build/libs') { unstash 'build' }
                sh '''
                    ls -l build/libs
                    ARTIFACT_SHA=$(openssl dgst -sha256 build/libs/gradle-site-plugin-0.6.jar | cut -d " " -f 2 -)
                    ./add_evidence.sh cern hadroncollider $ARTIFACT_SHA 'code review performed'
                    sleep 10
                '''
            }
        }
        stage('Test') {
            steps {
                echo 'Gathering integration test information....'
                dir('build/libs') { unstash 'build' }
                sh '''
                    ls -l build/libs
                    ls -l
                    ARTIFACT_SHA=$(openssl dgst -sha256 build/libs/gradle-site-plugin-0.6.jar | cut -d " " -f 2 -)
                    ./add_evidence.sh cern hadroncollider $ARTIFACT_SHA 'Integration tests performed'
                    sleep 10
                '''
            }
        }
    }
}
