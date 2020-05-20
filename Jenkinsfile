pipeline {
    agent any


    environment {
        CDB_HOST = 'http://server:8001'
        CDB_OWNER = 'meekrosoft'
        CDB_PROJECT = 'hadroncollider'
    }

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
                    ARTIFACT_SHA=$(openssl dgst -sha256 build/libs/accelerator-0.6.jar | cut -d " " -f 2 -)
                    echo "Artifact SHA is $ARTIFACT_SHA"
                    echo ARTIFACT_SHA=$ARTIFACT_SHA > artifact.sha
                    ./create_artifact.sh ${CDB_HOST} ${CDB_OWNER} ${CDB_PROJECT} $ARTIFACT_SHA accelerator-0.6.jar "Created by jenkins build ${BUILD_NUMBER}" "${GIT_COMMIT}" "${GIT_URL}commit/${GIT_COMMIT}" "${BUILD_URL}"
                '''
                stash includes: 'build/libs/*', name: 'build'
            }
        }
        stage('Add Code Review information') {
            steps {
                echo 'Gathering code review information....'
                dir('build/libs') { unstash 'build' }
                sh '''
                    sleep 10
                    ls -l build/libs
                    ARTIFACT_SHA=$(openssl dgst -sha256 build/libs/accelerator-0.6.jar | cut -d " " -f 2 -)
                    ./add_evidence_review.sh ${CDB_HOST} ${CDB_OWNER} ${CDB_PROJECT} $ARTIFACT_SHA APPROVED "Code review checked in build ${BUILD_NUMBER}"
                '''
            }
        }
        stage('Test') {
            steps {
                echo 'Gathering integration test information....'
                dir('build/libs') { unstash 'build' }
                sh '''
                    sleep 10
                    ls -l build/libs
                    ls -l
                    ARTIFACT_SHA=$(openssl dgst -sha256 build/libs/accelerator-0.6.jar | cut -d " " -f 2 -)
                    ./add_evidence_integration_tests.sh ${CDB_HOST} ${CDB_OWNER} ${CDB_PROJECT} $ARTIFACT_SHA integration_test "Integration tests performed in build ${BUILD_NUMBER}"
                '''
            }
        }
        stage('Security Scan') {
            steps {
                echo 'Performing security vulnerability scan....'
                dir('build/libs') { unstash 'build' }
                sh '''
                    sleep 10
                    ls -l build/libs
                    ls -l
                    ARTIFACT_SHA=$(openssl dgst -sha256 build/libs/accelerator-0.6.jar | cut -d " " -f 2 -)
                    ./add_evidence_security.sh ${CDB_HOST} ${CDB_OWNER} ${CDB_PROJECT} $ARTIFACT_SHA security_scan "Security scan performed in build ${BUILD_NUMBER}"
                '''
            }
        }
    }
}
