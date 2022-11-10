pipeline {
    agent any

    stages {
        stage ('Clean file') {
            steps {
                cleanWs()
            }
        }

        stage ('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/mariareee/IDWEB_App_-forsimulations.git'
                
            }
        }
    
    }
}