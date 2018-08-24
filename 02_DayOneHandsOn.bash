### DAY 2 handson ###
## User/Hostname information
# user@ostname: osgdev@TG-DevOps-OS087
# passwd: osg@1234

## Variables
my_log_d=/home/osgdev/Worklog/logs
my_wipro_id=serdeen
my_wipro_pwd=Escrever0u0u0u0u
my_wipro_email=sergio.mendes@wipro.com
my_git_proj=batch6SMM
my_git_url=https://topgear-training-gitlab.wipro.com/SERDEEN/batch6SMM.git
export my_log_d my_wipro_id my_wipro_pwd my_wipro_email my_git_proj my_git_url

#0.
##clear
mkdir Worklog ; cd Worklog
script Day2_wl.log ; cd

#1. Check for availability of Git: 
git --version
#git version 2.7.4
#2. Create a folder to work with GIT Local Repository. Normally the folder where the code is generated and required to be version controlled is made as GIT local repository. 
cd
mkdir gitlab 
cd gitlab 
ls -a
#. ..
git init
#Initialized empty Git repository in /home/osgdev/gitlab/.git/ 
ls -a
#. .. .git

#3. Let us generate some code:
echo \
"class Welcome{
public static void main(String[] args){
System.out.println( \"Welcome to DevOps Certification Program\");
}
}" > Welcome.java

cat Welcome.java
ls -a

#4. Status here is showing that the code Welcome.java need to be staged before commit.
git status

#5. Staging would make git local repo to consider file for version control.
git add Welcome.java 
git status
git status -s


#6. Commit the staged contents in local repository:
git commit -m "initial commit"

#7. Commit happened but often we missout mentioning who made the commit. Here the log is showing general user “osgdev”.
git log

#8. Change user details for commit and redo the commit to amend the user details.
git config --global user.name $my_wipro_id 
git config --global user.email $my_wipro_email

#Note: When you execute the following command, if a file opens in "nano" editor 
#press ctrl+x to exit from the file and use "Y" (yes) to save the commit changes, 
#and accept the file (path shown) in which it will be saved.
git commit --amend --reset-author

#9. Make a small change by adding another line to code:
echo \
"class Welcome{
public static void main(String[] args){
System.out.println(\"Welcome to DevOps Certification Program\");
System.out.println(\"### Initial Code Modified ###\");
}
} " > Welcome.java

cat Welcome.java

#10. Status show that the code is modified post the commit:
git status

#11. You can stage and commit together with the help of -a flag used in git commit:
git commit -a -m "Modified Code-2"

git status
#On branch master
#nothing to commit, working directory clean

git log

#12. Checking your code at different version.
#Check your code at present:
cat Welcome.java

#Switch to earlier version using the code given for "initial commit" on git log
git checkout 084f35016e3598b1a6b4c38ddd8ea9bfaeaaab9f

#Note: checking out '084f35016e3598b1a6b4c38ddd8ea9bfaeaaab9f'.
#...

cat Welcome.java

git checkout a552ff6fb8bc57dcbf31a6fee4f58b4b047fadb6
#Previous HEAD position was 084f350... initial commit
#...

#13. UNTIL 17. --> in pdf screenshots

#18. Push local repository details to Remote/Central Repository

git remote add origin $my_git_url
git push -u origin master
#Username for 'http://topgear-training-gitlab.wipro.com': prakaram
#Password for 'http://prakaram@topgear-training-gitlab.wipro.com':
#...
#Branch master set up to track remote branch master from origin.

#19. UNTIL 22. --> in pdf screenshots

#23. Clone the code from remote repository to local repository:
cd
git clone $my_git_url
#Cloning into 'my_git_proj'...
#...

#24. You may edit the code again and commit and push the same back to gitlab:
cd $my_git_proj
cat Welcome.java
git status -s
#M Welcome.java
git commit -a -m "Cloned and Modified"
#[master c18ea63] Cloned and Modified

#25. Pretty printing the git log:
git log --pretty=format:"%h %ad | %s%d [%an]" --date=short

#26. Tagging Important Version:
git tag v1.0 
git log --pretty=format:"%h %ad | %s%d [%an]" --date=short
#...
#1a16bb1 2018-07-19 | Initial Code [Prakash]
git checkout 1a16bb1
#Note: checking out '1a16bb1'.

cat Welcome.java

git checkout v1.0
#Previous HEAD position was 1a16bb1... Initial Code
#...
cat Welcome.java

#27. Reversing the staging:
#Make a change to the code.
echo \
"class Welcome{
public static void main(String[] args){
System.out.println(\"Welcome to DevOps Certification Program\");
System.out.println(\"### Initial Code Modified ###\");
System.out.println(\"### This code is entered at GitLab ###\");
System.out.println(\"### This code is modified after clone ###\");
System.out.println(\"### Making Additional Changes ###\");
}
}" > Welcome.java
git status
#On branch master
#...

git add Welcome.java
git status
#On branch master
#Your branch is up-to-date with 'origin/master'.
#...

git reset HEAD Welcome.java
#Unstaged changes after reset:
#...

git status
#On branch master
#Your branch is up-to-date with 'origin/master'.
#...

#28. Reversing Commit:
cat Welcome.java
git add Welcome.java 
git status
#On branch master
#Your branch is up-to-date with 'origin/master'.
#...

git commit -m "another modification"
#[master 2987cc1] another modification
#1 file changed, 1 insertion(+)

git log --pretty=format:"%h %ad | %s%d [%an]" --date=short
#...
git revert HEAD
#[master ddfda73] Revert "another modification"
#...

cat Welcome.java

# Though the code is erased, the commit information is still in the log:
git reset --hard v1.0
#...

#HEAD is now at c18ea63 Cloned and Modified 
git log --pretty=format:"%h %ad | %s%d [%an]" --date=short
#...

#29. Branching and Merging:
git branch
#* (HEAD detached at v1.0)
#master

git log --pretty=format:"%h %ad | %s%d [%an]" --date=short
#c18ea63 2018-07-19 | Cloned and Modified (HEAD, tag: v1.0, origin/master, origin/HEAD, master) [Prakash]
#...

#30. Create new branch "newfeature"
git branch newfeature 
git branch
#* (HEAD detached at v1.0)
#master
#newfeature 

git checkout newfeature
#Switched to branch 'newfeature' 

git branch
#master
#* newfeature 

git checkout master
#Switched to branch 'master'
#Your branch is up-to-date with 'origin/master'.

git branch
#* master
#newfeature

#31. Switch to branch "newfeature" and make change to code:
git checkout newfeature
#Switched to branch 'newfeature'
git branch
#master
#* newfeature 
echo \
"class Welcome{
public static void main(String[] args){
System.out.println(\"Welcome to DevOps Certification Program\");
System.out.println(\"### Initial Code Modified ###\");
System.out.println(\"### This code is entered at GitLab ###\");
System.out.println(\"### This code is modified after clone ###\");
System.out.println(\"### Adding a new feature ###\");
}
}" > Welcome.java

cat Welcome.java
#32. Commit the code change on the branch "newfeature":
git log --pretty=format:"%h %ad | %s%d [%an]" --date=short
#c18ea63 2018-07-19 | Cloned and Modified (HEAD -> newfeature, tag: v1.0, origin/master, origin/HEAD, master) [Prakash]
#...

git commit -a -m "Adding New Feature"
#[newfeature 8ef7ee4] Adding New Feature
#...

#33. While the code is modified on "newfeature", the code on master still remain the same:
git checkout master
#Switched to branch 'master'
#Your branch is up-to-date with 'origin/master'.

git branch
#* master
#newfeature

git log --pretty=format:"%h %ad | %s%d [%an]" --date=short
#c18ea63 2018-07-19 | Cloned and Modified (HEAD -> master, tag: v1.0, origin/master, origin/HEAD) [Prakash]
#...

cat Welcome.java

#34. Assuming that some new feature is developed and tested on the branch "newfeature", now you may merge these changes to the code on "main" branch:
git branch
#* master
#newfeature 

git merge newfeature
#Updating c18ea63..8ef7ee4
#Fast-forward
#Welcome.java | 1 +
#1 file changed, 1 insertion(+) 

git branch
#* master
#newfeature 

git log --pretty=format:"%h %ad | %s%d [%an]" --date=short
#8ef7ee4 2018-07-19 | Adding New Feature (HEAD -> master, newfeature) [Prakash]
#...

cat Welcome.java

#35. Compiling Java code:
javac Welcome.java 
java Welcome

# Welcome to DevOps Certification Program
### Initial Code Modified ###
### This code is entered at GitLab ###
### This code is modified after clone ###
### Adding a new feature ###

#36. UNTIL 45. --> in pdf screenshots
