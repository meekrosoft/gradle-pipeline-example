pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
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
                    echo ./create_artifact.sh cern hadroncollider $ARTIFACT_SHA gradle-site-plugin-0.6.jar "Created by build ${BUILD_NUMBER}"
                '''
            }
        }
        stage('Add Code Review information') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
