pipeline {
    agent any

    stages {
        stage('Preparation') {
            steps {
                echo 'Подготовка рабочей области StockFlow...'
                sh 'pwd'
                sh 'ls -la'
                sh 'test -f index.html'
                sh 'test -f test.sh'
            }
        }

        stage('Build') {
            steps {
                echo 'Сборка демонстрационного интерфейса склада...'
                sh 'rm -rf build && mkdir -p build'
                sh 'cp index.html build/index.html'
            }
        }

        stage('Test') {
            steps {
                echo 'Проверка результата сборки...'
                sh 'chmod +x test.sh'
                sh './test.sh build/index.html'
            }
        }

        stage('Package') {
            steps {
                echo 'Формирование архива сборки...'
                sh 'tar -czf stockflow-build.tar.gz -C build index.html'
                archiveArtifacts artifacts: 'stockflow-build.tar.gz', fingerprint: true
            }
        }
    }

    post {
        success {
            echo 'Pipeline StockFlow успешно завершён.'
        }
        failure {
            echo 'Pipeline StockFlow завершился с ошибкой. Проверьте Console Output.'
        }
        always {
            echo "Завершена сборка №${env.BUILD_NUMBER}"
        }
    }
}
