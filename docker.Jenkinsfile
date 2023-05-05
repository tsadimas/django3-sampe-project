pipeline {

    agent any

    environment {
            DOCKER_TOKEN = credentials('docker-push-secret')
            DOCKER_USER = 'tsadimas'
            DOCKER_SERVER = 'ghcr.io'
            DOCKER_PREFIX = 'ghcr.io/tsadimas/django'
        }

    stages {

        stage('Clone') {
            steps {
                git branch: 'main', url: 'git@github.com:tsadimas/django3-sampe-project.git'
            }
        }
    

        stage('Test') {
                steps {
                    sh '''
                        python3 -m venv myvenv
                        source myvenv/bin/activate
                        pip install -r requirements.txt
                        cd myproject
                        cp myproject/.env.example myproject/.env
                        python manage.py test
                    '''
                }
            }

        stage('docker build') {
            steps {
                sh '''
                    HEAD_COMMIT=$(git rev-parse --short HEAD)
                    TAG=$HEAD_COMMIT-$BUILD_ID
                    docker build --rm -t $DOCKER_PREFIX:$TAG -t $DOCKER_PREFIX:latest -f nonroot-alpine.Dockerfile .
                    echo $DOCKER_TOKEN | docker login $DOCKER_SERVER -u $DOCKER_USER --password-stdin
                    docker push $DOCKER_PREFIX --all-tags
                '''
            }
        }
    }
}