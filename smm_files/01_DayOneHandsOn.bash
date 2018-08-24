### DAY 1 handson ###
## User/Hostname information
# user@ostname: osgdev@TG-DevOps-OS087
# passwd: osg@1234
## Variables Information
# my_log_d=/home/osgdev/Worklog/logs

## Variables
my_log_d=/home/osgdev/Worklog/logs
my_wipro_id=serdeen
my_wipro_pwd=Escrever0u0u0u0u
my_wipro_email=sergio.mendes@wipro.com
my_git_proj=batch6SMM
my_git_url=https://topgear-training-gitlab.wipro.com/SERDEEN/batch6SMM.git
export my_log_d my_wipro_id my_wipro_pwd my_wipro_email my_git_proj my_git_url


## Create a directory “WorkLog” which will be having handson log for all rest of the sessions: 
## Note: Generating the Worklog script is for your personal use to refer to your handson activity at a later date 

##clear
mkdir Worklog ; cd Worklog
script Day1_wl.log ; cd

## Check availability of Git
##clear
git --version

## Check environment variable JAVA_HOME and PATH settings in the machine
##clear
echo "Java Home: $JAVA_HOME"
echo "Path: $PATH"

## Check availability of java
##clear
java -version

## Check availability of Maven
##clear
mvn --version

## Check availability of Tomcat Services

# Start the Tomcat Service
##clear
mkdir $my_log_d/tomcat_5050
sudo nohup \
/home/osgdev/mytomcat/apache-tomcat-8.5.27/bin/startup.sh \
> $my_log_d/tomcat_5050/tomcat_5050.out

# URL: http://localhost:5050

# Shutdown the Tomcat Service
sudo /home/osgdev/mytomcat/apache-tomcat-8.5.27/bin/shutdown.sh

## Check for availability of Artifactory
sudo systemctl status artifactory 

# Start artifactory
mkdir $my_log_d/artifactory
sudo nohup \
/opt/jfrog/artifactory/bin/artifactory.sh\
> $my_log_d/artifactory/artifactory.out &

tail -f $my_log_d/artifactory/artifactory.out

# Stop artifactory
sudo systemctl stop artifactory 


# URL: http://localhost:5040/artifactory

## Check availability of SonarQube

# Download the required scripts SonarQube
cd ~/Worklog/
git clone http://topgear-training-gitlab.wipro.com/AVITEPA/MyVDIconfig/
cd MyVDIconfig
ls
#doStartServices.sh doStopServices.sh sonarProperties.pl

# Sart SonarQube services
mkdir $my_log_d/SonarQube
cd ~/Worklog/MyVDIconfig
sudo nohup \
./doStartServices.sh \
> $my_log_d/SonarQube/SonarQube.out &

tail -f $my_log_d/SonarQube/SonarQube.out

# URL: http://127.0.0.1:6060/sonar

# Shutdown SonarQube services
sudo bash ./doStopServices.sh



## Check availability of Firefox Webdriver (geckodriver)
whereis geckodriver
# geckodriver: /usr/bin/geckodriver

#Note: used as link between selenium tests and firefox browser

## Check availability of Jenkins
service jenkins status

# URL: http://localhost:8080/
