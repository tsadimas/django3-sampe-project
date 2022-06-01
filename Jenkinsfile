pipeline {
    agent any

     environment {
            DOCKER_TOKEN = credentials('docker-push-secret')
            DOCKER_USER = 'tsadimas'
            DOCKER_SERVER = 'ghcr.io'
            DOCKER_PREFIX = 'ghcr.io/tsadimas/django3-sampe-project'
        }


    stages {
        stage('Build') {
            steps {
                // Get some code from a GitHub repository
                git branch: 'k8s', url: 'https://github.com/tsadimas/django3-sampe-project.git'

                
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
                    sed -i 's#^DATABASE_URL.*#DATABASE_URL=sqlite:///.test.db#g' myproject/.env
                    ./manage.py test'''
            }
        }
        // stage('Deploy') {
        //     steps {
        //         sshagent (credentials: ['ssh-deployment-1']) {

        //         sh '''
        //             pwd
        //             echo $WORKSPACE
        //             ansible-playbook -i ~/workspace/ansible-project/hosts.yml -l deploymentservers ~/workspace/ansible-project/playbooks/check.yml
        //             '''
        //     }
        //     }
        // }
         stage('Docker create and push image') {
         
            steps {
                sh '''
                HEAD_COMMIT=$(git rev-parse --short HEAD)
                TAG=$HEAD_COMMIT-$BUILD_ID
                docker build --rm -t $DOCKER_PREFIX:$TAG -t $DOCKER_PREFIX:latest  .
                echo $DOCKER_TOKEN | docker login $DOCKER_SERVER -u $DOCKER_USER --password-stdin
                docker push $DOCKER_PREFIX --all-tags
                '''
            }
        }
        stage('Deploy to k8s') {
            steps {
                sh '''
                kubectl config use-context microk8s
                cd k8s/db
                ls *.yaml | while read x; do kubectl apply -f $x; done
                '''
            }
        }
        stage('Deploy db to k8s using Helm') {
            steps {
            sh '''
            helm repo add bitnami https://charts.bitnami.com/bitnami
            helm repo update
            helm upgrade --install my-db bitnami/postgresql -f k8s/db-values.yaml
            '''
            }
        }

    }
}
