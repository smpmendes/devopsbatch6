### DAY 3 handson ###
## User/Hostname information
# user@ostname: osgdev@TG-DevOps-OS087
# passwd: osg@1234

## Variables
my_log_d=/home/osgdev/Worklog/logs
my_wipro_id=serdeen
my_wipro_pwd=Escrever0u0u0u0u
my_wipro_email=sergio.mendes@wipro.com
my_git_proj=jarproject
my_git_url=https://topgear-training-gitlab.wipro.com/SERDEEN/$my_git_proj.git
export my_log_d my_wipro_id my_wipro_pwd my_wipro_email my_git_proj my_git_url



#1. Check availability:

java -version

echo $JAVA_HOME

mvn --version

whereis mvn

echo $PATH

#Create a folder to work on Maven:
mkdir mvnlab 
cd mvnlab

#2. Generate a project archetype that would generate jar file:
mvn \
archetype:generate \
-DgroupId=com.devops \
-DartifactId=Demo1 \
-DarchetypeArtifactId=maven-archetype-quickstart \
-DinteractiveMode=false

#3. Review project structure and check auto-generated pom.xml, sample main code and junit test code:
ls

tree Demo1

cat Demo1/pom.xml

cat Demo1/src/main/java/com/devops/App.java

cat Demo1/src/test/java/com/devops/AppTest.java

#4. Validate whether project is correct and all necessary information is available:
cd Demo1
mvn validate

#5. Compile the source code of the project and review the project structure:
mvn compile

tree .

#6. Clean and review the folder structure:
mvn clean

tree .

#7. Test the compiled source code using suitable unit testing framework and Review the project structure:
#Note: since the project structure is cleaned, it would again be compiled.
mvn test

tree .

#8. Clean and Package the code in a distributable format and review the project structure:
mvn clean package

tree .

#9. Verify the package generated to check on results of integration tests 
#to ensure quality criteria and review the folder structure:
mvn verify

tree .

#10. Install the project in local repository:
mvn install

#11. Find the local repository in the below location:
ls /home/osgdev/.m2/repository/com/devops/Demo1/1.0-SNAPSHOT
#Demo1-1.0-SNAPSHOT.jar maven-metadata-local.xml
#Demo1-1.0-SNAPSHOT.pom _remote.repositories

#12. Generate project structure whose artifact type would be war:
cd ..
mvn \
archetype:generate \
-DgroupId=com.devops \
-DartifactId=Demo2 \
-DarchetypeArtifactId=maven-archetype-webapp \
-DinteractiveMode=false

#13. Review project structure and check auto-generated pom.xml, sample main code and Junit test code:
ls
#Demo1 Demo2 

tree Demo2

cat Demo2/pom.xml

#14. Validate the project and review the folder structure:
cd Demo2
mvn validate

#15. Compile the project and review the folder structure:
mvn compile

tree .

#16. Clean the project and review the folder structure:
mvn clean

tree .

#17. Test and review the folder structure. Since test cases are not associated, 
#just the corresponding folder structure gets created.
mvn test

tree .

#18. Package the project and review the folder structure for the package generated.
mvn clean package

tree .

#19. Verify the package generated:
mvn verify

#20. Install the package in the local repository:
mvn install

#21. Watch the package files in local repository:
ls /home/osgdev/.m2/repository/com/devops/Demo2/
#1.0-SNAPSHOT maven-metadata-local.xml 

ls /home/osgdev/.m2/repository/com/devops/Demo2/1.0-SNAPSHOT/
#Demo2-1.0-SNAPSHOT.pom maven-metadata-local.xml
#Demo2-1.0-SNAPSHOT.war _remote.repositories

#22. Use Jenkins to work with Maven JAR Project:
#Push the source code of project to remote git repository:
cd Demo1

ls
#pom.xml src

#Initialized empty Git repository in /home/osgdev/mvnlab/Demo1/.git/
git init

ls -a
#. .. .git pom.xml src

git add .

git commit -m "Commit jar project"

git log

#23. Create new project in topgear-training-gitlab.wipro.com:
#Provide project name “jarproject” and make it public:
#New project created. Copy the HTTP url to clipboard.

#24. Use the URL to push the code from local repository to remote repository:
cd ~/mvnlab/Demo1

git remote add origin $my_git_url

git push -u origin master
#Username for 'http://topgear-training-gitlab.wipro.com': my_wipro_id
#Password for 'http://serdeen@topgear-training-gitlab.wipro.com':
#...

#25. Refresh the webpage to check pushing of code to remote repository:


#26. Create a new jarproject by clicking on “New Items” in Jenkins Dashboard:
#Choose the project to be “Maven project”

#27. Specify the URL of gitlab remote repository from where the code need to be pulled.

#28. Choose the default setting for Build Triggers, 
#as we are manually triggering the build process.

#29. For Build process, choose Root POM as ‘pom.xml’ and 
#Build Goal as “clean package”. Click on Apply and Save.

#30. Click on “Build Now” to start building “jarproject”. Under “Build History”, watch the start of build process. Click on this, and in the next screen click on “Console Output” to watch the progress of build process.


#31. Return to dashboard and click on “jarproject”, to get to workspace where in target folder, you will get packaged war file.


#32. Right click on jar file to get link location of jar file: 
#http://localhost:8080/job/jarproject/ws/target/Demo1-1.0-SNAPSHOT.jar
wget localhost:8080/job/jarproject/ws/target/Demo1-1.0-SNAPSHOT.jar

#--2018-07-22 16:51:22-- http://localhost:8080/job/jarproject/ws/target/Demo1-1.0-SNAPSHOT.jar
#Resolving localhost (localhost)... ::1, 127.0.0.1
#Connecting to localhost (localhost)|::1|:8080... connected.
#HTTP request sent, awaiting response... 200 OK
#Length: 2085 (2.0K) [application/java-archive]
#Saving to: ‘Demo1-1.0-SNAPSHOT.jar’
#Demo1-1.0-SNAPSHOT. 100%[===================>] 2.04K --.-KB/s in 0s
#2018-07-22 16:51:22 (131 MB/s) - ‘Demo1-1.0-SNAPSHOT.jar’ saved [2085/2085]

#33. Package location in local machine:
ls /var/lib/jenkins/workspace/
#ansible-demo asdf Build_Job_Bookstore GitShell jarproject 

ls /var/lib/jenkins/workspace/jarproject/
#pom.xml src target 

ls /var/lib/jenkins/workspace/jarproject/target/
#classes maven-archiver surefire-reports
#Demo1-1.0-SNAPSHOT.jar maven-status test-classes

#34. Let us repeat previous steps for war package. 
#Push the source code for war project to remote git repository. Use the following screenshot to return to screen, from where you can create new project on GITLAB:
cd ~/mvnlab/Demo2 
ls
#pom.xml src 

git init
#Initialized empty Git repository in /home/osgdev/mvnlab/Demo2/.git/

ls -a
. .. .git pom.xml src 

git add . 

my_git_proj=warproject
my_git_url=https://topgear-training-gitlab.wipro.com/SERDEEN/$my_git_proj.git
export my_git_proj my_git_url

git commit -m "$my_git_proj"

git remote add origin http://topgear-training-gitlab.wipro.com/SERDEEN/$my_git_proj.git

git push -u origin master
#Username for 'http://topgear-training-gitlab.wipro.com': serdeen
#Password for 'http://serdeen@topgear-training-gitlab.wipro.com':
#Counting objects: 9, done.
#...

#35. Create “warproject” in Jenkins:

#36. Set the URL of GITLAB remote repository:

#37. Set the Build goal to “clean package”. Click on Apply and Save.

#38. Click on “Build Now” and by clicking on “Build History” go to console output.

#39. Return to dashboard and click on the project,and go to workspace 
#and target folder in the workspace to get the packaged war file:

#40. Right click on Demo2.war file to get following link location:
wget http://localhost:8080/job/warproject/ws/target/Demo2.war

ls /var/lib/jenkins/workspace/
#ansible-demo asdf Build_Job_Bookstore GitShell jarproject warproject 

ls /var/lib/jenkins/workspace/warproject/
#pom.xml src target 

ls /var/lib/jenkins/workspace/warproject/target/ 
#Demo2 Demo2.war maven-archiver


