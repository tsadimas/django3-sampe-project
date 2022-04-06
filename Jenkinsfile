pipeline {
    agent any


    stages {
        stage('Build') {
            steps {
                // Get some code from a GitHub repository
                git branch: 'main', url: 'https://github.com/tsadimas/django3-sampe-project.git'

                
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
                    ./manage.py test'''
            }
        }
        stage('install ansible prerequisites') {
            steps {
                sh '''
                    ansible-galaxy install geerlingguy.postgresql
                '''
            }
        }
        stage('Prepare DB') {            
            steps {
                sshagent (credentials: ['ssh-deployment-1']) {
                    sh '''
                        pwd
                        echo $WORKSPACE

                        ansible-playbook -i ~/workspace/ansible-project/hosts.yml -l database ~/workspace/ansible-project/playbooks/postgres.yml
                        '''
            }
            }
        }
        stage('deploym to vm 1') {
            steps{
                sshagent (credentials: ['ssh-deployment-1']) {
                    sh '''
                        ansible-playbook -i ~/workspace/ansible-project/hosts.yml -l deploymentservers ~/workspace/ansible-project/playbooks/django-project-install.yml
                    '''
                }

            }

        }
    }
}
