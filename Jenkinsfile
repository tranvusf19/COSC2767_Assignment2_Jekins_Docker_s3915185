pipeline {
    agent any
    tools {
        maven 'maven-3.9.5'
        git 'Git'
    }
    stages {
        stage('Clone') {
            steps {
                git branch: 'main', url: 'https://github.com/tranvusf19/COSC2767_Assignment2_Jekins_Docker_s3915185.git'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }
        stage('Publish Over SSH'){
            steps {
                sshPublisher(publishers: [sshPublisherDesc(configName: 'docker-server', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: 'Dockerfile')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
                
                sshPublisher(publishers: [sshPublisherDesc(configName: 'docker-server', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '''cd /home/dockeradmin
                docker build -t tomcat .
                docker stop tomcat-container
                docker rm tomcat-container
                docker run -d --name tomcat-container -p 8080:8080 tomcat''', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: 'target', sourceFiles: 'target/*.war')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            }
        }
    }
}
