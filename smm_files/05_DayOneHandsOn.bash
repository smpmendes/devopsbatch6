### DAY 4 handson ###
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

#Automated deployment using Jenkins:
#1. Install the plugin
Click on Install without restart.

#Restart the Jenkins server.
sudo systemctl restart jenkins
#[sudo] password for osgdev: << osg@1234 >>

#2. Configure Jenkins project “warproject”
#3. Configure the Build Trigger to initiate frequent builds of project:
Provide schedule for every 5 mins as “H/5 * * * *”

#4. Configure Post Build Actions and choose “Deploy war/ear to a container”. This will be enabled only if the plugin “Deploy to container” is successfully installed.
#5. Specify the WAR/EAR files as “***/*war”, so that war file generated in Jenkins workspace can be choosen automatically. Provide Jenkins credentials using the dialog box shown in next screen shot to add Jenkins Credentials and choose the same in drop down menu, once it is populated.
#Specify the base tomcat URL. Click on Apply and Save.

#6. Use the following screenshot to add credentials as follows.
#Username: admin
#Password: admin

#7. Start Tomcat Server, before building the project to ensure that war file is placed in appropriate tomcat server.
#Start the Tomcat Service:


#### Kill all tomcat running
mkdir -p $my_log_d/mytomcat_5050
cd ~/mytomcat
./apache-tomcat-*/bin/startup.sh 

#Shutdown the Tomcat Service:
cd ~/mytomcat/apache-tomcat-*/bin/
./shutdown.sh 

#8. Demonstrating Continuous Integration or Build Automation:
#In the following demonstration, “warproject” defined above integrates 
#Git and Maven tools for version control and build and automatically deploys 
#the war file in the running tomcat server.
#Present Source Code with Change - 01: 
cat ./src/main/webapp/index.jsp
<html>
<body>
<h2>Hello World!</h2>
<p>Making Change - 01</p>
</body>
</html>
Build History:
Present Webpage:

#9. Source Code with Change - 02:
cd ~/mvnlab/Demo2
cat ./src/main/webapp/index.jsp
#<html>
#<body>
#<h2>Hello World!</h2>
#<p>Making Change - 01</p>
#<p>Making Change - 02</p>
#</body>
#</html>

#Push the code to remote gitlab repository:
git add . 

git commit -m "change 2"

git push -u origin master
# Username for 'http://topgear-training-gitlab.wipro.com': serdeen

#10. Source Code with Change - 03:
cat ./src/main/webapp/index.jsp
#<html>
#<body>
#<h2>Hello World!</h2>
#<p>Making Change - 01</p>
#<p>Making Change - 02</p>
#<p>Making Change - 03</p>
#</body>
#</html> 

git add . 

git commit -m "change 3"

git push -u origin master
#Username for 'http://topgear-training-gitlab.wipro.com': serdeen

#11. Source Code with Change - 04:
cat ./src/main/webapp/index.jsp
#<html>
#<body>
#<h2>Hello World!</h2>
#<p>Making Change - 01</p>
#<p>Making Change - 02</p>
#<p>Making Change - 03</p>
#<p>Making Change - 04</p>
#</body>
#</html> 

git add . 

git commit -m "change 4"

git push -u origin master
#Username for 'http://topgear-training-gitlab.wipro.com': serdeen
#...

#12. Source Code with Change - 05:
cat ./src/main/webapp/index.jsp
#<html>
#<body>
#<h2>Hello World!</h2>
#<p>Making Change - 01</p>
#<p>Making Change - 02</p>
#<p>Making Change - 03</p>
#<p>Making Change - 04</p>
#<p>Making Change - 05</p>
#</body>
#</html> 

git add . 

git commit -m "change 5"

git push -u origin master
Username for 'http://topgear-training-gitlab.wipro.com': serdeen

#Build History:
#Webpage after Refresh: