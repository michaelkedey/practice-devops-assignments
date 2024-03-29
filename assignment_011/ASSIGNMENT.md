## CICD PIPELINE WITH JENKINS, SONARQUBE, TOMCAT, MAVEN AND NEXUS

### PART I (Servers)
1. **Provission 4 servers for the 5 applications**
- **[SonarQube Server](../assignment_010/ASSIGNMENT.md)**
- **[Nexus Server](../assignment_010/ASSIGNMENT.md)**
- **[Tomcat Server](../assignment_009/ASSIGNMENT.md)**
- **[Maven Server](../assignment_009/ASSIGNMENT.md) (optional)**
- **JENKINS SERVER**
    - **t2.medium ec2 instance**
    - **ssh access**
    - **ssh into your jenkins server and change the hostname to jenkins**
    - **switch to user `ubuntu`**
    - **update and upgrade  the system**
    - **Install [Java17-JRE](assignment_resources/jdk-vs-jre.md) and [fontconfig](assignment_resources/fontconfig.md)**
        - **eg.**
        ```
        sudo apt install fontconfig openjdk-17-jre -y
        java -version
        ```

    - **Install Jenkins**
        - **download the jenkins gpg key file from ` https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key` and save it in the `/usr/share/keyrings/` directory as `jenkins-keyring.asc`**

        - **add the jenkins repository `https://pkg.jenkins.io/debian-stable` to the `apt` configuration and use the gpg key you configured earlier `/usr/share/keyrings/jenkins-keyring.asc` for package verification**
        ```
        sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
        ```

        - **update and upgrade the system**

        - **install jenkins**
        ```
        sudo apt-get install jenkins
        ```

    - **Enable and start the jenkins service**
    eg.
    ```
    sudo systemctl  enable jenkins
    sudo systemctl start jenkins
    ```
    
    - **Access jenkins on the web on port  8080**
    - **Follow the instructions to get the initial passwaord and log in**
    - **Install suggested plugins,and create the first admin user**
    - **Maintain the default instance configuration `http://jenkins-server-ip-address:8080` and start using jenkins**


### PART II (Git and Github)
1. **For this part, you can either use the [jomacs web-app repo](https://github.com/JOMACS-IT/web-app.git), or your own maven [web app](../assignment_009/ASSIGNMENT.md) you built in assignment_009**

2. **Fork the [jomacs web-app repo](https://github.com/JOMACS-IT/web-app.git) to your [Github](https://www.github.com) if you haven't already, clone the forked repo from your own github to your local environment.**

3.  **If you're using your own maven [web app](../assignment_009/ASSIGNMENT.md) however, create a repo on your [Github](https://www.github.com), clone the repo to your local environemnt, `cd` into the repo, and build your maven [web app](../assignment_009/ASSIGNMENT.md), and push the code to github**
    - **you'll need to have [maven](https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.zip) installed and added to your environment variables**

    - **you'll need to also have [java](https://download.oracle.com/java/22/latest/jdk-22_windows-x64_bin.exe) installed**

    - **you'll need to configure git credentials on your local  machine**


### PART III (CICD)
1. **On your jenkins web inetrface, navigate to dashboard --> manage jenkins --> plugins --> available plugins**

2. **Search and install these plugins:**
    - **SonarQube Scanner (for sonarqube)**
    - **Nexus Artifact Uploader (for nexus)**
    - **Pipeline Utility Steps (for better pipeline building experience)** 
    - **Pipeline Maven Integration (for maven)**
    - **Blue Ocean (for viewing job outputs)**
    - **Deploy to Container (for tomcat)**

3. **Add maven and sonarqube as tools, on the jenkins server**
    - **Navigate back to dashboard --> manage jenkins --> tools**
    - **Scroll down to maven installations and click on add maven**
        - **name: maven**
        - **version: 3.9.6 (default)**
        - **apply and save**

    - **Scroll down to sonarqube scanner installations and click on add sonarqube scanner**
        - **name: sonarqube**
        - **version: 5.0.1 (default)**
        - **apply and save**

4. **Generate a sonarqube token to be used on the jenkins server for authenticating sonarqube deployments**
    - **on your sonarqube server, navigate to account --> security --> generate token**
    - **name: name your token**
    - **token type: global analysis token**
    - **expires in: select an expiration time**
    - **generate and copy.**

5. **Add the generated sonarqube token on your jenkins server.**
    - **on your jenkins server, navigate to dashboard --> manage jenkins --> system**
    - **scroll down to sonarqube servers**
    - **check the environment variables box**
    - **add sonarqube**
        - **name: sonarqube**
        - **server url: your_sonrqube_server_url:8080**
        - **token: add jenkins token**
            - **domain: default**
            - **kind: secret text**
            - **scope: global**
            - **secret: paste the token you generated and copied from the sonarqube server**
            - **id: give it an id (eg: sonarqube-token)**
            - **description: give it a description**
            - **add**
        - **server authentication token: select the token you just created**
        - **apply and save**

6. **Create your first freestyle job on Jenkins by navigating to dashboard --> New Item**
    - **name: give your job a name (eg. first_job)**
    - **select: freestyle project**
    - **ok.**
    - **description: give your job  a description**
    - **source code management: git**
        - **repository url: paste in the web-app url you cloned from jomacs, or your own maven web-app you built and pushed to github**
        - **credentials: none (unless you created a private repo)**
        - **branches to build: main**
    - **build steps: invoke top level maven target**
        - **maven version: maven**
        - **goals: clean package**
    - **apply and save**

7. **Build your first job**
    - **navigate to dashboard --> select your job --> build now** 
    - **notice the succes (green check mark) on the lower left of your page.**
    - **click on the green check mark to see the console output**
    - **you can also use blueocean to achieve same result**

8. **Create your second job (pipeline) on Jenkins by navigating to dashboard --> New Item**
    - **name: give your job a name**
    - **select: pipeline**
    - **ok.**
    - **description: give your job  a description**
    - **scroll down and select pipeline syntax**
        - **sample step: git**
        - **repo url: paste in the web-app url you cloned from jomacs, or your own maven web-app you built and pushed to github**
        - **credentials: none (unless you created a private repo)**
        - **branch: main**
        - **generate pipeline script, and copy the generated script**
    - **on your local environment in the root of your `web-app` project, create a new file called `Jenkinsfile` and start writing your pipeline script, stage by stage**
    - **paste the copied script into the appropriate stage of the [Jenkinsfile](assignment_resources/Jenkinsfile) (git clone step)**
    - **add two more stages to your `Jenkinsfile` for maven `packaging` and `testing`, as demonstarted in the [Jenkinsfile](assignment_resources/Jenkinsfile) in the [assignment_resources](assignment_resources)**
    - **now copy the entire [Jenkinsfile](assignment_resources/Jenkinsfile) which at this stage should contain three stage.**
    - **navigate to dashboard --> select your job --> configure**
    - **scroll down and paste the generated script you copied into the script box**
    - **apply and save**

9. **Build your second pipeline job**
    - **navigate to dashboard --> select your job --> build now**
    - **notice the succes (green check mark) on the lower left of your page.**
    - **click on the green check mark to see the console output**
    - **you can also use blueocean to achieve same result**

10. **Updaate your `Jenkinsfile` by pasting the contents of the [sonarqube stage](assignment_resources/Jenkinsfile-sonarqube)**
    - modify as necessary

11. **Build your pipeline job after updating your pipeline script with the sonarqube stage**
    - **navigate to dashboard --> select your job --> build now**
    - **notice the succes (green check mark) on the lower left of your page.**
    - **click on the green check mark to see the console output**
    - **you can also use blueocean to achieve same result**

12. **On your sonarqube server, notice that your project has been uploaded and scanned**

13. **On your nexus server, create a new maven2(hosted) repository, either snapshot or release and enable redeploy**

14. **On the jenkins server, generate another pipeline script for nexus deploymment**
    - **navigate to dashboard --> your_pipeline -->configure**
    - **scroll down and select pipeline syntax**
    - **sample step: nexusArtifactUploader: Nexus Artifact Uploader**
    - **nexus verison: nexus 3**
    - **protocol: http**
    - **nexus url: the nexus_server_url:8081, without 'http://'**
    - **credentials: add jenkins**
        - **domain: default**
        - **kind: username with password**
        - **scope: global**
        - **username: nexus username**
        - **password: nexus password**
        - **id: give it an id**
        - **description: give it a description**
        - **add**
    - **credentials: select the nexus credential you just created**
    - **group id: get the group id from the `pom.xml` file in the root directory  of your web app, inside the project tag**
    - **version: from the `pom.xml` file (change to eithe snapshot or release, depending on the repo you created on nexus)**
    - **repository: nexus repository name you created**
    - **add artifacts**
        - **artifact id: from the `pom.xml` file**
        - **type: war**
        - **file: `/var/lib/jenkins/workspace/your_workspace/target/your-web-app.war` (to get ths, on your jenkins server cli (terminal), navigate to `/var/lib/jenkins/workspace/your_workspace/target` and copy the full path to your packaged artefact. you can use `pwd` to get the path)**
    - **generate pipeline script, and copy the generated script**
    - **paste the copied script into the appropriate stage of your [Jenkinsfile](assignment_resources/Jenkinsfile)**
    - **now copy the entire [Jenkinsfile](assignment_resources/Jenkinsfile) which at this stage should  contain four stages.**
    - **navigate to dashboard --> select your pipeline job --> configure**
    - **scroll down and paste the generated script you copied into the script box**
    - **apply and save**

15. **Build your pipeline job after updating your pipeline script with the second stage (nexus deployment)**
    - **navigate to dashboard --> select your job --> build now**
    - **notice the succes (green check mark) on the lower left of your page.**
    - **click on the green check mark to see the console output**
    - **you can also use blueocean to achieve same result**

16. **On your nexus server, notice that the artefact has been deployed to the repo you created**

17. **Generate another pipeline script for tomcat deployment**
    - **navigate to dashboard --> your_pipeline -->configure**
    - **scroll down and select pipeline syntax**
    - **sample setp: deploy war/ear to container**
    - **war/ear file: target/*.war**
    - **add container: Tomcat 9.x Remote**
    - **credentials: add jenkins**
        - **domain: default**
        - **kind: username and password**
        - **scope: global**
        - **usernae: your tomcat server username**
        - **password: your tomcat server password**
        - **id: give it an id (eg. tomcat-jenkins)**
        - **description: describe what this is used for (eg. Deploying application to tomcat via Jenkins).**
        - **add**
    - **credentials: the tomcat credential you just created**
    - **tomcat url: your_tomcat_server_url:8080**
    - **generate pipeline script, and copy the generated script**
    - **paste the copied script into the appropriate stage of your [Jenkinsfile](assignment_resources/Jenkinsfile)**
    - **now copy the entire [Jenkinsfile](assignment_resources/Jenkinsfile) which at this stage should  contain five stages.**
    - **navigate to dashboard --> select your pipeline job --> configure**
    - **scroll down and paste the generated script you copied into the script box**
    - **apply and save**

18. **Build your pipeline job after updating your pipeline script with the third stage (tomcat deployment)**
    - **navigate to dashboard --> select your job --> build now**
    - **notice the success (green check mark) on the lower left of your page.**
    - **click on the green check mark to see the console output**
    - **you can also use blueocean to achieve same result**

19. **On your tomcat server, notice that the artefact has been deployed to the webapps direcory, which you can view on the managers app**

20. **Alternatively, you can generate syntaxes for all your stages, create your `Jenkinsfile`, use that as your pipeline script and build once**

20. **On your local environemnt, Push your updated web-app repo which now contains your own `Jenkinsfile` to your github**


### CONGRATULATIONS, you have successfully built a jenkins pipeline
#### Questions?  Ask in slack! 


###  HAPPY LEARNING
    
#### TECHNOLOGIES
**CICD Pipeline, Jenkins (CI/CD tool), SonarQube (Code analysis tool), Tomcat (Application server), Maven (Build automation tool), Nexus (Repository manager), Git (Version control system), Github (Web-based version control repository and hosting service), Java (Programming language), Maven (Build automation tool for Java projects), Shell scripting (For automating tasks on the servers), Fontconfig, SSH, EC2, Ubuntu**








