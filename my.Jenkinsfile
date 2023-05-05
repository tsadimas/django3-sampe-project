pipeline {
    agent any

    stages {
        stage('Build') {
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

        stage('Deploy database') {
            steps {
                sh '''
                    ansible-galaxy install geerlingguy.postgresql
                '''

                sh '''
                    ansible-playbook -i ~/workspace/ansible-project/hosts.yml -l deploy-vm-1 ~/workspace/ansible-project/playbooks/postgres.yml
                '''
            }
        }

        stage('Deploy Django') {

            steps {
                sh '''
                    mkdir -p ~/workspace/ansible-project/files/certs
                    cd ~/workspace/ansible-project/files/certs
                    openssl req -x509 -newkey rsa:4096 -keyout server.key -out server.crt -days 365 --nodes -subj '/C=GR/O=myorganization/OU=it/CN=myorg.com'
                '''
                sh '''
                    ansible-playbook -i ~/workspace/ansible-project/hosts.yml -l deploy-vm-1 ~/workspace/ansible-project/playbooks/django-project-install.yml
                '''
            }
        }


    }

}