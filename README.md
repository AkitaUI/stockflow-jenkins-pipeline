# StockFlow — Jenkins Pipeline demo

Учебный репозиторий для практической работы № 4 по дисциплине «Методологии разработки программного обеспечения».

Проект имитирует сборку небольшого интерфейса системы управления складом интернет-магазина. Jenkins получает исходные файлы из GitHub, формирует каталог `build`, запускает проверки и публикует архив сборки как Jenkins artifact.

## Состав репозитория

- `Jenkinsfile` — декларативный Jenkins Pipeline.
- `index.html` — демонстрационная страница складских остатков.
- `test.sh` — проверки содержимого собранной страницы.
- `.gitattributes` — фиксация LF для shell-скрипта и Jenkinsfile.
- `.gitignore` — исключение локальных результатов сборки.

## Этапы Pipeline

1. **Preparation** — проверка рабочей области и наличия входных файлов.
2. **Build** — создание каталога `build` и копирование `index.html`.
3. **Test** — проверка наличия ожидаемых элементов StockFlow в собранном файле.
4. **Package** — создание `stockflow-build.tar.gz` и сохранение архива в Jenkins через `archiveArtifacts`.

## Публикация на GitHub

Создайте пустой публичный репозиторий `stockflow-jenkins-pipeline` (без автоматического README), затем из этой папки выполните:

```bash
git init -b main
git add .
git commit -m "Initial StockFlow CI pipeline"
git remote add origin https://github.com/<USERNAME>/stockflow-jenkins-pipeline.git
git push -u origin main
```

Замените `<USERNAME>` на имя своего GitHub-пользователя.

## Настройка Jenkins

Создайте Item типа **Pipeline**, например `StockFlow-CI`. В разделе Pipeline задайте:

- Definition: `Pipeline script from SCM`
- SCM: `Git`
- Repository URL: HTTPS URL вашего GitHub-репозитория
- Branch Specifier: `*/main`
- Script Path: `Jenkinsfile`

Для публичного репозитория credentials не требуются. Сохраните задание и нажмите **Build Now** / **Собрать сейчас**.

## Ожидаемый результат

Сборка должна пройти этапы Preparation, Build, Test и Package. В результате Jenkins сохранит артефакт `stockflow-build.tar.gz`. Фактический статус сборки определяется только после запуска Pipeline.

## Запуск Jenkins в Docker (PowerShell)

Выполняйте команды при запущенном Docker Desktop. В методических указаниях приводится тег с JDK 17; в этой инструкции используется актуальный LTS Alpine-тег с JDK 21.

```powershell
docker pull jenkins/jenkins:lts-alpine-jdk21
docker volume create jenkins_home
docker run -d --name stockflow-jenkins `
  -p 8080:8080 -p 50000:50000 `
  -v jenkins_home:/var/jenkins_home `
  --restart=on-failure jenkins/jenkins:lts-alpine-jdk21
```

Первоначальный пароль администратора можно получить командой:

```powershell
docker exec stockflow-jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

Откройте `http://localhost:8080`, завершите первоначальную настройку Jenkins и затем создайте Pipeline согласно инструкции выше.
