# Setting Up Maven and Tomcat on EC2 Instance for CI/CD, and implementig a simple maven generated web app project.

1. **Launch a new EC2 instance and name it CICD, with ssh access and port 8080 open in your inbound rules.**

2. **SSH into your instance**

3. **Change the hostname e.g. sudo hostnamectl set-hostname cicd**

4. **Update your system e.g. ```sudo apt-get upgrade -y && sudo apt-get update -y```**

5. **Install the default Java JDK e.g. sudo apt-get install default-jdk**

6. **Download Maven and Tomcat zipped files using wget**
   e.g. sudo wget https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz && sudo wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.85/bin/apache-tomcat-9.0.85.tar.gz

7. **Extract the zip files e.g. sudo tar -xzvf apache-maven-3.9.6-bin.tar.gz && sudo tar -xzvf apache-tomcat-9.0.85.tar.gz**

8. **Remove the zipped packages after extraction e.g. sudo rm apache-maven-3.9.6-bin.tar.gz && sudo rm apache-tomcat-9.0.85.tar.gz**

9. **Rename and move the extracted directories to the /opt directory**
   e.g. sudo mv apache-maven-3.9.6/ /opt/maven && sudo mv apache-tomcat-9.0.85/ /opt/tomcat9

10. **Modify the environment variables by editing the .bashrc file**
    e.g. sudo vi ~/.bashrc
    ```
    export M2_HOME=/opt/maven/
    export PATH=$PATH:$M2_HOME/bin
    ```

11. **Save and exit**

12. **Reload the .bashrc file e.g. source ~/.bashrc**

13. **Verify Maven is installed e.g. mvn -version**

14. **Enable all access to the Tomcat directory e.g. sudo chmod 777 -R /opt/tomcat**

15. **Enable easy access to starting and stopping Tomcat by creating symbolic links**
    e.g. sudo ln -s /opt/tomcat9/bin/startup.sh /usr/bin/starttomcat && sudo ln -s /opt/tomcat9/bin/shutdown.sh /usr/bin/stoptomcat

16. **Verify Tomcat is working by visiting instance-ip-address:8080 from your browser**

17. **Create a new directory called my-app in your home directory and move into it**

18. **Use Maven to generate a new web-app project**
    e.g. mvn archetype:generate -DgroupId=com.example -DartifactId=my-app -DarchetypeArtifactId=maven-archetype-webapp

19. **Modify the contents of the src/main/webapp/index.jsp file**

20. **Clean and package your app by running e.g. mvn clean package in the root of your web app directory**

21. **Copy the packaged WAR file in the target directory to the webapps directory of Tomcat9**
    e.g. sudo cp target/my-app.war /opt/tomcat9/webapps/

22. **Start Tomcat by calling the link you created earlier e.g. sudo starttomcat**

23. **Modify Tomcat configurations to allow access to the manager app from any IP by editing the context.xml file**
    e.g. sudo vi webapps/manager/META-INF/context.xml

24. **Create a new Tomcat user and add roles to enable accessing the manager app**
    e.g. sudo vi conf/tomcat-users.xml

25. **Start Tomcat e.g. sudo starttomcat**

26. **Open instance-ip-address:8080, navigate to the manager app, login with the user you created, scroll down and notice your web-app**

27. **Did it work?**
