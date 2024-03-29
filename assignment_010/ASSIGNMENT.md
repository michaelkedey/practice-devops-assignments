# Implementing SORNAQUBE server installation for code scanning, and nexus server for artifact storage

### PART I (SonarQube Server)
1. **Provission an ec2 instnace of type t2.medium, or t2.large**

2. **Enable ssh access, and name your instance sonarqube**

3. **SSH into your instance and set up your work environemnt**

4. **updating and upgrading your system**
eg.
```
sudo apt-get update -y && sudo apt-get upgrade -y

```

5. **set the hostname  of your machine to "sonar"**
eg.
```
sudo hostnamectl set-hostname sonar

```

6. **switch to user ubuntu**

7. **Configure [Elasticsearch](assignment_resources/elastic_search.md)**
    - **modify the contents of `/etc/sysctl.conf` by adding the following lines of code:**
    eg.
    ```
    sudo vi /etc/sysctl.conf

    vm.max_map_count=262144
    fs.file-max=65536
    ulimit -n 65536
    ulimit -u 4096

    ```

    - **save and exit**

8. **Apply the configuration by reboting your system.**
eg.
```
sudo reboot

```

9. **Install/add the official [PostgreSQL repository](assignment_resources/postgress_repo.md) to your system's list of package sources and also add the repository's GPG key for package verification**
eg.
```
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'

wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | sudo apt-key add -

```

10. **Update your package list and install postgrSQL**
eg.
```
    sudo apt update && sudo apt install postgresql postgresql-contrib -y

```

11. **Enable and start the postgres service**
eg.
```
sudo systemctl enable postgresql && sudo systemctl start postgresql

```

12. **By default, a new postgres user called postgres is created when you install postgres. Change the postrgess user password**

13. **Create a new user named sonar as user postgres using the psql shell, and create a password for the new user**
eg.
```
sudo -u postgres psql -c "CREATE ROLE sonar WITH LOGIN ENCRYPTED PASSWORD 'your password';"

```
- you can also switch to the user postgres, switch to the  psql shell, create the sonar user and do further configurations in the psql shell.

14. **Switch to the postgres shell and create a new database called sonarqube and grant all privileges to the user sonar, also specify the user sonar as the owner of the database**
eg.
```
sudo -u postgres psql

CREATE DATABE sonarqube OWNER sonar;

GRANT ALL PRIVILEGES ON DATABASE sonarqube to sonar;

```

15. **Exit from the psql shell**
eg.
```
\q

```

16. **Install java**
eg.
```
cd /opt/

sudo apt-get install openjdk-17-jdk zip -y

java -version

```

17. **Dowanload sonarqube, rename the downloaded directory and clean up the redundant zipped package**
eg.
```
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.9.4.87374.zip && sudo unzip sonarqube-9.9.4.87374.zip && sudo rm -rf sonarqube-9.9.4.87374.zip && sudo mv sonarqube-9.9.4.87374/ sonarqube

```

18. **Create a new group named sonar, and a new user also named sonar, add the new user sonar, to the group sonar, and specify the new user's home directory as the sonarqube installtion directory**
eg.
```
sudo groupadd sonar
sudo useradd sonar -g sonar -d /opt/sonarqube

```

19. **Change the ownership of the sonarqube installtion directory, to the new user sonar, you created**
eg.
```
sudo chown -R sonar:sonar /opt/sonarqube

```

20. **In order for sonarqube to connect to the psql database, modify the sonarqube configuration file `/opt/sonarqube/conf/sonar.properties` and set the database, username and password to those configured earlier on the sonarqube database in postggresql**
eg.
```
sudo vi /opt/sonarqube/conf/sonar.properties

sonar.jdbc.username=username
sonar.jdbc.password=pasword
sonar.jdbc.url=jdbc:postgresql://localhost:5432/sonarqube

```

21. **Save and exit**

22. **Configure a Systemd service for the SonarQube application by creating a new service file named `sonar.service` in the `/etc/systemd/system/`**
eg.
```
sudo vi /etc/systemd/system/sonar.service

```
- **Add the following [sonerqube configuration](assignment_resources/sonerqube_service.md)**

23. **Reload systemd configuration files and units**
eg.
```
sudo systemctl daemon-reload


```

24. **Now you can perform systemctl commands such as , start, stop, status, etc on the sonarqube service you created.**
eg.
```
sudo systemctl enable sonar
sudo systemctl start sonar
sudo systemctl status sonar

```

25. **Access sonerqube by via the srevers public ipaddress on port 9090**
- Default username and password is admin
- Change the password to any of your choice, after your first login
- The default testing rule for SonarQube is [Sonar Way](assignment_resources/sonar_way.md)
- Be sure to allow traffic on port 9000 in your security group rules, on the aws console


### PART II (Nexus Server)
1. **Provission an ec2 instnace of type t2.large**

2. **Enable ssh access, and name your instance nexus**

3. **SSH into your instance and set up your work environemnt**

4. **updating and upgrading your system**
eg.
```
sudo apt-get update -y && sudo apt-get upgrade -y

```

5. **set the hostname  of your machine to "nexus"**
eg.
```
sudo hostnamectl set-hostname nexus

```

6. **switch to user ubuntu**

7. **Create a user aclled nexus to manage the nexus service, and add the new user to the soders file and grant te user/group unrstricted access to all commands without the need for a password.**
eg.
```
sudo adduser nexus

sudo echo "nexus ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/nexus

```

8. **Switch to the nexus user**

9. **Install Java 8 in the `/opt/` directory**
eg.
```
cd /opt
sudo apt install openjdk-8-jdk -y
java -version

```

10. **Download the nexus zipped package, extract it and clean up the zipped package and rename the nexus directory**
eg.
```
sudo wget https://download.sonatype.com/nexus/3/nexus-3.65.0-02-unix.tar.gz && sudo tar -xzvf nexus-3.65.0-02-unix.tar.gz

sudo rm -rf nexus-3.65.0-02-unix.tar.gz && sudo mv nexus-3.65.0-02 nexus

```

11. **Change the ownership of nexus and sonatype-work directories to be owned by the recursively nexus user**.
eg.
```
sudo chown -R nexus:nexus /opt/nexus
sudo chown -R nexus:nexus /opt/sonatype-work

```

12. **Add the nexus user to the nexus configuration file. The nexus user in the nexus.rc file is responsible for managing the Nexus Repository.**
eg.
```
sudo vi /opt/nexus/bin/nexus.rc

```
- uncomment this line `run_as_user="nexus"` and add the nexus user

13. **Configures a Systemd service for the Nexus application by creating a new service file named `nexus.service` in the `/etc/systemd/system/`**
eg.
```
sudo vi /etc/systemd/system/nexus.service

```
- **Add the following [nexus configuration](assignment_resources/nexus_service.md)**
    
    
14. **Reload systemd configuration files and units**
eg.
```
sudo systemctl deamon-reload

```

15. **Now you can perform systemctl ommand such as , start, stop, status, etc on the sonarqube service you created.**
eg.
```
sudo systemctl enable nexus
sudo systemctl start nexus
sudo systemctl status nexus

```

16. **Access nexus web portal via the severs public ip address on port 8081**
- Be sure to allow traffic on port 8081 in your security group rules, on the aws console
- your login credentials are in the `/opt/sonatype-work/nexus3/admin.password` file
- Create repository
- maven2(hosted)
- name # enter a prefered name
- version policy # release or snapshot
- deployment policy # allow redeploy
- create a release repository
- Create a snapshot repository

## PART III (Maven Application)
1. **For this part, you can either use the [jomacs web-app repo](https://github.com/JOMACS-IT/web-app.git), or your own maven [web app](../assignment_009/ASSIGNMENT.md) you built in assignment_009 (you can chhpse to exclude the tomcat configuration this time around)**

2. **If you use the [jomacs web-app repo](https://github.com/JOMACS-IT/web-app.git), modify the `pom.xml` file in the root directory of the web-app and paste in the contents of the [properties.xml](assignment_resources/properties.xml) file**

3. **If you use your own maven [web app](../assignment_009/ASSIGNMENT.md), modify the `pom.xml` file in the root directory of the web-app and paste in the contents of the [sonarqube plugin](assignment_resources/sonarqube_plugin.xml) file**
- create a test directory inside your src directory of your web-app
- You can leave out the tomcat configurtions, and also the `index.jsp` file modification

4. **Clean and package your code into a deployable artifact and scan with sonerqube**
eg.
```
mvn sonar:sonar

```

5. **Go to the sonerqube web portal and notice your project directory.**


### PART IV (Maven Application 2)
1. **Modify the contents of the `pom.xml` file on your maving server and paste in the contents of the [distribution_mgt.xml](assignment_resources/distribuion_mgt.xml) file within the build tags**  
eg.
```
sudo vi pom.xml vi 

```

2. **Modify the contents of the `settings.xml` file on your maven server and paste in the contents of the [settings.xml](assignment_resources/settings.xml) file inside ther servers tag**
eg.
```
sudo vi /opt/maven/conf/settings.xml

```
- The id of the [settings.xml](assignment_resources/settings.xml) configuration must be tge same as the id in the [distribution_mgt.xml](assignment_resources/distribuion_mgt.xml)cofiguration.

- Inside your `pom.xml` file, change the version from SNAPSHOT to RELEASE, in order to deploy a relese artifact to nexus, and vice versa.

3. **Package the artificat and deploy to nexus**
eg.
```
mvn clean package
mvn deploy

```

### HAPPY LEARNING

