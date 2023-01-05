pipeline {
           agent any
    
        parameters {
            booleanParam(name: 'CLEAN_WORKSPACE', defaultValue: true, description: '***')
            booleanParam(name: 'TESTING_FRONTEND', defaultValue: false, description: '**')
        }
        
        environment {
            ON_SUCCESS_SEND_EMAIL = "true"
            ON_FAILURE_SEND_EMAIL = "true"
        }
    
         stages {
            stage ('Remove previous files') {
                steps {
                    cleanWs()
                }
            }
            
            stage ('Checkout') {
                steps {
                    git branch: 'master', url: 'https://github.com/mariareee/IDWEB_App_-forsimulations.git'
                }
            }
            
            stage('Restore packages') {
                steps {
                    bat "dotnet restore ${workspace}\\RunGroopWebApp.sln"
                }
            }
            
            stage('Build') {
                steps {
                    bat "dotnet build --configuration Release ${workspace}\\RunGroopWebApp.sln"
                }
            }
            
            stage('Testing Backend') {
                steps {
                    bat "dotnet test ${workspace}\\RunGroopsWebApp.Test\\bin\\Release\\net6.0\\RunGroopsWebApp.Test.dll --logger \"junit;LogFilePath=..\\Results\\${JOB_NAME}\\result_build_${BUILD_NUMBER}.xml\""
                }
            }
            
            stage('Testing Frontend') {
                steps {
                    script {
                        if (params.TESTING_FRONTEND == true)
                        {
                            echo "--> Testing_Frontend = ${params.TESTING_FRONTEND}"
                        }
                    }
                }
            }
            
            stage ('Clean workspace') {
                steps {
                    script {
                        if (params.CLEAN_WORKSPACE == true) {
                            cleanWs()
                            echo "Workspace cleared"
                        } else {
                            echo "Workspace not cleared"
                        }
                        
                    }
                }
            }

            stage('Test Integration') {
                steps {
                    dir('../Results') {
                        junit (testResults: '**/${JOB_NAME}/result_build_${BUILD_NUMBER}.xml', allowEmptyResults : true)
                    }
                }
                
                post {
                    success {
                        script {
                            ON_FAILURE_SEND_EMAIL = "false"
                        }
                    }
                    
                    failure {
                        script {
                            ON_SUCCESS_SEND_EMAIL = "false"
                        }
                    }
                    
                    cleanup {
                        script {
                            if(ON_SUCCESS_SEND_EMAIL == "true"){
                                emailext body: "SUCCESS!\nJOB_NAME: ${JOB_NAME}\nBUILD_NUMBER: ${BUILD_NUMBER}\nBUILD_URL: ${BUILD_URL}", subject: 'WebService Pipeline: SUCCESS', to: 'mariasadovoi@gmail.com'
                            } else if(ON_FAILURE_SEND_EMAIL == "true") {
                                emailext body: "FAILURE!\nJOB_NAME: ${JOB_NAME}\nBUILD_NUMBER: ${BUILD_NUMBER}\nBUILD_URL: ${BUILD_URL}", subject: 'WebService Pipeline: FAILURE', to: 'mariasadovoi@gmail.com'
                            }
                        }
                    }
                
                }
            }
            
            
        }
    
    }