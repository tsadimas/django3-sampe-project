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
                    ansible-galaxy install geerlingguy.java
                    ansible-playbook -l db01 ~/workspace/ansible-project/playbooks/postgres.yml
                '''
            }
        }


    }

}