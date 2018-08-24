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


####################################
## lots of printscreens on the pdf

#1. Enable Artifactory:
cd ~/mvnlab/Demo2
sudo systemctl stop artifactory

mkdir $my_log_d/jfrog
sudo nohup \
/opt/jfrog/artifactory/bin/artifactory.sh \
> $my_log_d/jfrog/jfrog_8040.out &

tail -f $my_log_d/jfrog/jfrog_8040.out

#2. Check on the URL: http://localhost:8040/artifactory

#3. Click on login and enter following credentials:
Username: admin
Password: password

#4. Move the mouse over the panel on left side, and click on Artifacts to check available artifact repositories:
#Provide information about available Artifact repository:
#Select and check libs-snapshot-local.

#5. Configure Jenkins project to include binary repository:
#Click on “Manage Jenkins” to configure Artifactory in Jenkins:
#Click on “Configure System”
#Look for Artifactory
#Click on “Add Artifactory Server”. 
#Specify Artifactory URL and credentials. 
#Clicking on “Advanced” select “Bypass HTTP proxy”.
#Test the connection. Apply and Save.

#6. Click on “warproject” from the dashboard in Jenkins.

#7. Click on configure to make changes to project configuration.

#8. Add Post-build Actions in the project to select “Deploy artifacts to Artifactory”

#9. In the resulting dialog box, observe the URL of Artifactory server being automatically populated. Click on “Refresh” to select “libs-snapshot-local” for both Target releases repository and Target snapshot repository.

#10. Observe console output for deploying of Artifacts in artifactory.

#11. Refresh the Artifactory Repository Browser, to check for artifact stored in “libs-snapshot-local”

#12. Setup Tomcat Server to deploy war file:
#Download tomcat package.
#Often proxy blocks the download, which may require you
mkdir tomcat
cd tomcat
ls /home/osgdev/Downloads/
wget http://mirrors.up.pt/pub/apache/tomcat/tomcat-9/v9.0.11/bin/apache-tomcat-9.0.11.tar.gz

#13. In the “tomcat” work directory copy the tar file and untar the file.
cp /home/osgdev/Downloads/apache-tomcat-9* .
ls
#apache-tomcat-9.0.11.tar.gz

tar xvzf apache-tomcat-9*tar.gz

ls
#apache-tomcat-9.0.11 apache-tomcat-9.0.11.tar.gz

vi apache-tomcat-9.0.11/conf/server.xml
#14. Change port address in following lines from 8080 to 11022
#-->
#<Connector port="8080" protocol="HTTP/1.1"
#connectionTimeout="20000"
#redirectPort="8443" />
#<!-- A "Connector" using the shared thread pool-->
#-->
#<Connector port="11022" protocol="HTTP/1.1"
#connectionTimeout="20000"
#redirectPort="8443" />
#<!-- A "Connector" using the shared thread pool-->

#Note: As a precaution to avoid interference from existing tomcat server, 
#you may require to kill any existing process running tomcat server. 
#Remember not to kill Artifactory which also runs a tomcat server. If Artifactory 
#gives any trouble, then start Artifactory again using steps defined before.

ps -ef | grep tomcat
#osgdev 4840 18735 0 21:11 pts/23 00:00:00 grep --color=auto tomcat root 12417 12402 0 Jul24 ? 00:00:15 /docker-java-home/bin/java -Djava.util.logging.config.file=/usr/local/tomcat/conf/logging.properties -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Djdk.tls.ephemeralDHKeySize=2048 -

#sudo kill -9 12417
ps -ef | grep tomcat
#osgdev 7074 18735 0 21:13 pts/23 00:00:00 grep --color=auto tomcat

#15. Start Tomcat Server

mkdir -p $my_log_d/tomcat_11022
sudo nohup \
./apache-tomcat-9.0.11/bin/startup.sh \
> $my_log_d/tomcat_11022/tomcat_11022.out &

tail -f $my_log_d/tomcat_11022/tomcat_11022.out

#Using CATALINA_BASE: /home/osgdev/tomcat/apache-tomcat-9.0.11
#Using CATALINA_HOME: /home/osgdev/tomcat/apache-tomcat-9.0.11
#Using CATALINA_TMPDIR: /home/osgdev/tomcat/apache-tomcat-9.0.11/temp
#Using JRE_HOME: /usr/java/jdk1.8.0_162
#Using CLASSPATH: /home/osgdev/tomcat/apache-tomcat-9.0.11/bin/bootstrap.jar:/home/osgdev/tomcat/apache-tomcat-9.0.11/bin/tomcat-juli.jar Tomcat started.

#16. Check in the browser: http://localhost:11022

#17. Manual Deployment of war file generated by Maven and placed in Artifactory:
wget http://localhost:8040/artifactory/libs-snapshot-local/com/devops/Demo2/1.0-SNAPSHOT/Demo2-1.0-20180724.073138-1.war
#Demo2-1.0-20180724.073138- 100%[======================================>] 2.05K --.-KB/s in 0s
#2018-07-25 21:21:44 (179 MB/s) - ‘Demo2-1.0-20180724.073138-1.war’ saved [2098/2098]

ls
#apache-tomcat-9.0.11 apache-tomcat-9.0.11.tar.gz Demo2-1.0-20180724.073138-1.war
mv Demo2-1.0-20180724.073138-1.war Demo.war
cp Demo.war ./apache-tomcat-9.0.11/webapps/ 
ls apache-tomcat-9.0.11/webapps/
#Demo Demo.war docs examples host-manager manager ROOT

#18. Check in the browser: http://localhost:11022/Demo/