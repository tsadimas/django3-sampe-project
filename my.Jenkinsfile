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
                    python3 -m myvnenv
                    source myvenv/bin/activate
                    pip install -r requirements.txt
                    cd myproject
                    cp myproject/.env.example myproject/.env
                    python manage.py test
                '''
            }
        }

    }

}