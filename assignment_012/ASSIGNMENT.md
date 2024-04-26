## BUILDING DOCKER IMAGES AND RUNNING DOCKER CONTAINERS

##### This hands-on Docker project will guide you through setting up an EC2 instance, installing Docker, building Docker images from web applications, and running Docker containers. You'll also push these images to DockerHub and Amazon Elastic Container Registry (ECR).

### 1. Set Up EC2 Instance

- Launch an EC2 instance and name it "docker".
- Enable ssh acces
- Public Ip
- Assign Key pair
- Connect to the EC2 instance using SSH.

### 2. Install Docker

- **Set hostname to `docker`**
- **Update and upgrade packages**
- **Add Docker gpg keys for package authentication**
    - ```sudo apt-get install -y ca-certificates curl gnupg
        sudo install -m 0755 -d /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        sudo chmod a+r /etc/apt/keyrings/docker.gpg
    ```

- **Add the offical docker repo to system repositiries**
    - ```
        echo \
        "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
        "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt-get update
    ```

- **Install Docker from the added repo**
```
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo apt-get install -y docker-buildx-plugin docker-compose
```

- **Give permission to the Docker Daemon:**
```
sudo chmod 666 /var/run/docker.sock# Install Docker
sudo apt install docker.io
```

- **Check Docker version**
```
docker --version
```

### 3. Build First Docker Image

- Git clone this [Web-app](https://github.com/JOMACS-IT/web-app.git) repository
  
- Alternatively you can also clone [this repository](https://github.com/michaelkedey/web-app.git)
  
- Navigate to the root of the [Web-app](https://github.com/JOMACS-IT/web-app.git) repository you cloned

- Delete the contents of the `Dockerfile` and paste in the contents of [this Dockerfile](assignment_resources/Dockerfile)

- Build the application into a `docker image`
```
docker build -t web-app:v1 .
```

- on succesful build, you should see the docker image on your system when you run `docker images` to list all docker images on your system
- run `docker ps` and `docker ps -a` to see all running docker containers on your system

- Run the `docker image` you've built as a `docker conatiner` on port 8080. The first port number `8080` is the port on which the system listens on for requests, ad whenever there is any request comming through that port, the system send the request to the second port number `8080` which is the port number the docker container is running on
```
docker run -d --name web-app -p 8080:8080 web-app:v1
```
- on succesful run, you should see the docker container on your system when you run `docker ps` to list all docker containers on your system
- run `docker ps -a` to see all running docker containers on your system

- Open your browser and navigate to `http://ec2-public-ip:8080/web-app` to view your running `docker container`

- to remove a docker image, run `docker rmi image-name`
- be sure to stop the running docker container before removing it
- to stop a docker container, run `docker stop container-name`
- to remove a docker container, run `docker rm container-name`
- you can also use `docker rm $(docker ps -a -q --filter status=exited)` to remove all exited docker containers

- **Tag your docker image with a version number and push to [dockerhub](https://hub.docker.com/)**

```
docker tag web-app:v1 your-dockerhub-username/web-app:v1
```

- if you don't have a dockerhub account, create one [here](https://hub.docker.com/)

- **Afer creating an account, login to [dockerhub](https://hub.docker.com/) via the cli**
```
docker login -u your-dockerhub-username
```

- **enter your [dockerhub](https://hub.docker.com/) password**

- **on success ypu can now push the image you've built and taged to your dockerhub account**
```
docker push your-dockerhub-username/web-app:v1
```

- **navgigate to your dockerhub account from your browser and notice your pushed image**


### 4. Build Second & Third Docker Images

- **Fork this [practice-web-app repo](https://github.com/michaelkedey/practice-web-app/fork) and then git clone the forked repo from your own gtithub account to your working environemnt**

- **cd into the `practice-web-app` directory, create a new `git branch` and switch to the new branch from which you'll work**
```
cd practice-web-app
git checkout -b your-branch-name
```

- Read the instructions insid ethe `README.md` file, build and run the 2 docker images
  
- access the running conatiners via the browser on the system ports you associted with the conatiners

- Be sure to map different system ports to the docker conatiners to avoid port conflic errors. Eg if you have `port 8080`(`-p 8080:80`) already associated with a running container `80`, you should associate another port to the new container. `8081:80`

- Be sure to open all ports maped to te docker containers in your security groups inbound rules

- **Push both images to dockerhub**


### 5. Build FOURTH Docker Image

- **Working from your `git brnach` of the cloned `practice-web-app` repo, create a new directory for your new project and navigate into it:**
```
mkdir your-project-name && cd your-project-name
```

- **Inside the project directory, create an `index.html` file for a simple web page:**
    - paste in the contents of the [index.html](assignment_resources/index.html) file

- **Create a Dockerfile in the same directory to define the Docker image build instructions**
```
vi Dockerfile
```
  - `Dockerfile` contents
    ```
    # Use a base image with a lightweight Linux distribution
    FROM nginx:alpine

    # Copy the web application files into the nginx web server directory
    COPY index.html /usr/share/nginx/html/
    ```

- **Build the Docker Image**
```
docker build -t image-name:tag-name .
```

- **Run the Docker Container**
```
docker run -d --name container/image-name -p 8081:80 image-name
```

- **Access the web application by opening a web browser and navigate to http://ec2-public-ip:8081 to see your simple Dockerized web application running inside the Docker container.**

- **set your git username and email on the system**
```
git config --global user.name "your-github-username"
git config --global user.email "your-guthub-email"
git config --global --list
```

- **On github, click on `your account --> settings --> developer settings --> personal access tokens --> classic token` and create a new token**

- **Copy the created token and paste it somewhere safe before closing that webpage**


- **Add all the changes you've made to git tracking and push**
```
cd ..
git add .
git commit -m "you-commit-message"
git push origin your-branch-name
```

- **when asked for username and password, enter your git username and paste in the copied token as the password**

- **Tag your image and push to dockerhub**
```
docker tag image-name:tag your-dockerhub-username/image-name:your-tag
docker push your-dockerhub-username/html-app:your-tag
```

### 6. Push All Images to ECR (Amazon Elstic Container Registry)

- **install aws cli**
```
sudo apt-get install awscli -y
```

- **generate access keys for aws cli if you don't have one already**
    - on your aws console, navigate to iam dashboard --> users --> select your iam user and create a cli access key for that user.
    - download the `csv file` or copy the access key details before closing that page

- **add the generated acces key to aws cli**
```
aws configure
```
- enter necessary details including acces key id and secret
- set the default region to your iam-user default region
- you can set the default output to blank

- **create repos on ECR to store your images**
    - on your aws console, navigate to `ECR --> create repository (private)`
    - enter a name for your repository (same name as your image)
    - create

- **push your images to ECR**
    - select the created ECR repo and click on `view push commands`
    - follow steps number 1, 3 and 4 to succesfully login with awscli, tag your image and push to ECR.
    - modify the commands where necesarry

- **Share your dockerhub images with colleagues to pull and run on their systems**
```
docker pull your-dockerhub-username/image-name:your-tag
docker run -p 8080:8080 your-dockerhub-username/image-name:your-tag
```
eg.
```
docker pull michaelkedey/web-app:michaelkedey
```

### 6. Build Sixth Docker Image From Colleague's pulled web-app image (apache-web-app)

- **Create a new directory inside the root of the `practice-web-app` directory and cd into it.**
```
mkdir another-app && cd another-app
```
- **Inside the new directory, create a new file called `Dockerfile` and add the following content**
```
# Use your colleagues first web-app image as the base image
FROM michaelkedey/html-app:v1

COPY index2.html /var/www/html/index.html

# Start Apache HTTP Server in the foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]
```
- **Build the image**
```
docker build -t another-app .
```
- **Run the image**
```
docker run -p 8081:80 another-app
```
- **Open your browser and navigate to `http://localhost:8081`**

- **You should see the same page as the one you saw when you ran the image from your colleague's dockerhub account**


### HAPPY LEARNING