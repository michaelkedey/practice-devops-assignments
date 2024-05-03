## DevOps Journey: Containerization and Orchestration
### Introduction
***Welcome to a simulated DevOps role at a dynamic tech company! You've just been hired at Tech Co. as a DevOps engineer. Your primary task is to modernize the software development and deployment process by leveraging containerization and orchestration tools.***   

***Tech Co. is undergoing a digital transformation, aiming to streamline development and deployment pipelines for their web applications. The current infrastructure lacks scalability and consistency. Your mission is to introduce Docker and related tools to optimize these workflows.***

#### Requirements
1. Containerization with Docker
2. Docker Hub Setup
3. Amazon ECR Configuration
4. Orchestration with Docker Compose
5. Kubernetes

### Containerization with Docker
- fork the [web application source code](https://github.com/JOMACS-IT/example-voting-app/fork)
- clone the web application source code repository from the fork you created
  ```
  git clone https://github.com/michaelkedey/example-voting-app.git
  cd example-voting-app
  ```
- alternatively you can also fork and clone [this repo](https://github.com/nuviagithub/example-voting-app/fork)

- navigate through the source code directory structure and notice the existing **`Dockerfiles`**
- in the root of the source code directory:
    1. create a **`docker-compose.yml`** file similar to this [docker-compose.yml](assignment_resources/docker-compose.yaml) to define the services and their depenednecies and settings.
        - in the **`docker-compose`** file, we have defined the following services:
            - **`vote`**
            - **`result`**
            - **`worker`**
            - **`redis`**
            - **`db`**
        -  we also defined the following local volumes for the storage services to use:
            - **`redis-volume`**
            - **`db-volume`**
            - this is neceasrry to enable persistance of data accros container reboots and deletions
    2. create another file named **`.env`** and define your environment settings in there. see [.env](assignment_resources/env) for details
- build, pull and start all the containers defined in the [docker-compose.yml](assignment_resources/docker-compose.yml)
  ```
  docker compose up -d
  ```
- if you get an error message while building, among other troubleshooting methods, be sure to have enough space on your system. You can remove older images if you have space error.
- also be sure to check and remove local unattached volumes which may be taking up space should you encounter any error relating to insufficient storage.
    ```
    docker volume ls
    docker volume rm <volume-name>
    ```
- to check the logs of a particular image if it's failing to run, use 
    ```
    docker compose logs image-name
    ``` 
    - eg. 
        ```
        docker compose logs vote
        ```
- if you get any errors such as **`import error`** on the **`vote`** service, copy the contents of the [requirments.txt](assignment_resources/requirments.txt) file and paste it in the **`requirements.txt`** file in the **`vote`** directory.
- to check the status of the containers, use 
    ```
    docker ps
    docker ps -a
    ``` 
- to check the logs of a particular container, use 
    ```
    docker logs container-name
    ```
    - eg.
        ```
        docker compose logs vote
        ```

- to check the logs of a particular image, use 
    ```
    docker logs image-id
    ```
    - eg.
        ```
        docker logs 53685804cc76 
        ```

- to stop all running containers, use 
    ```
    docker stop $(docker ps -a -q)
    ``` 
- to remove all containers that have been stoped or failed to run (exited), use 
    ```
    docker rm $(docker ps -a -q --filter status=exited)
    ``` 
- to remove all images from your system, use 
    ```
    docker rmi -f $(docker images -a -q)
    ``` 
- to run all images from your **`docker-compose.yml`** file, use 
    ```
    docker compose up -d
    ``` 
- to stop and remove all containers(running and stopped) and networks, use
    ```
    docker-compose down
    ```

- to run a particular image from your **`docker-compose.yml`** file, use 
    ```
    docker compose up -d image-name
    ``` 
    - eg.
        ```
        docker compose up -d vote
        ```

- Alternatively you can create the volumes individually and attach them to the images
    - To create a volume, use 
        ```
        docker volume create volume-name
        ```
        - eg.
            ```
            docker volume create vote-db
            ```
        
    - To check the volumes on your system, use 
        ```
        docker volume ls
        ```
    - To attache the created volume to a service in the **`docker-compose.yml`** file, make sure the container is not running, and use
        ```
        docker-compose run -d -v volume-name:path-in-container image-name
        ```
        - eg.
            ```
            docker compose run -d -v redis-volume:/data redis
            ```

    - To remove all unused anonymous local volumes, use
        ```
        docker volume prune
        ```
    - use **`ls /var/lib/docker/volumes`** to view all local volumes on your system
    - to access your apps, open **`ec2-public-ip-addres:port-specifid-in-docker-copomse-file`** from your browser
    - youcan also use **`localhost:port`** to achieve same thing
        eg.
            ```
            localhost:8080
            ```

### Docker Hub
- tag the 3 sservices with your dockerhub username and push to dockerhub
    ```
    docker tag example-voting-app-vote:latest your-dockerhub-username/vote:latest
    docker tag example-voting-app-redis:latest your-dockerhub- username/redis:latest
    docker tag example-voting-app-worker:latest your-dockerhub-username/worker:latest
    ```
    - eg.
        ```
        docker tag example-voting-app-vote:latest michaelkedey/vote:latest
        ``` 
- push to dockerhub
    ```
    docker push your-dockerhub-username/vote:latest
    ```
    - eg.
        ```
        docker push  michaelkedey/vote:latest
        ```
    - be sure to login to dockerhub via your cli before pushing
        ```
        docker login
        ```

### ECR
- on your aws console, navigate to ECR and create a private repository, with the same name as the image ypu want to push to ECR
- After creation, click on the repo, and select **`view push commands`**
- Follow steps 1, 3 and 4 to succesfully push your images to ECR
    - Be sure to have `awscli` on your system
    - Be sure to have the right credentials configured on **`awscli`**
        ```
        aws configure
        ```
    - Be sure to have your aws user access key details from AWS console and use those to configure **`awscli`** , create and download or copy the access key details of your aws user if you don't have those.


### Github 
- Push all the changes made in your sourcecode repo to your github account.
    ```
    git add .
    git commit -m "commit message"
    git push origin branch-name
    ```

### K8S
- kubernetes deployment files have been defined in the **`k8s-spcecifications`** directory.
- navigate to the **`k8s-spcecifications`** durecoty and notice the various **`.yaml`** configuration files.
- make sure you have [minikube](https://minikube.sigs.k8s.io/docs/start/) installed and configured
- to start the minikube sigle node cluster, run **`minikube start`**
- to verify if there are any pods running on your nod, use **`kubectl get pods`**
- to view [namespaces](assignment_resources/namespace.md) on your node, run **`kubectl get ns`**
- use **`kubectl create ns example-voting-app`** to crate a new namespace and create the resources in there.
- to switch to the name space you created, use
  ```
  kubectl config set-context --current --namespace=example-voting-app
  ```
- to view the current ns (namespace) you're on, use **`kubectl config view --minify -o jsonpath={..namespace}`**
- to view all the resources in the namespace, use **`kubectl get all`**
- inside the **`k8s-spcecifications`** run the various deployment files to create the deployments
    - **`db-deployment.yaml`**
    - **`redis-deployment.yaml`**
    - **`result-deployment.yaml`**
    - **`vote-deployment.yaml`**
    - **`worker-deployment.yaml`**
    - eg.
        ```
        kubectl create -f db-deployment.yaml
        ``` 
- verify that the deployments are created
  ```
  kubectl get deployments
  ```
- verify the pods are created
  ```
  kubectl get pods
  ```

- inorder to access the pods in the deployment we need to create services for the pods.
- open the various `service.yaml` files and notice the configurations, pay attention to the various `port` numbers
    - port
    - target port
    - node port

- inside the **`k8s-spcecifications`** run the various service files to create the services
    - **`db-service.yaml`**
    - **`redis-service.yaml`**
    - **`result-service.yaml`**
    - **`vote-service.yaml`**
    - **`worker-service.yaml`**
    - eg.
        ```
        kubectl create -f db-service.yaml
        ``` 
- verify the services are created
  ```
  kubectl get svc
  ```
- to access the vote and result `services` from your browser, you can get the the `ip address` of your node and the `node port` for the particular service
- us **`kubectl describe svc vote`** to get detals about the vote service, including the node port
to get the node ip address, notice the internal ip adrress:
```
kubectl get nodes -o wide
```
- you can also access the service from within the cluster by running
  ```
  curl node-ip:nodeport
  ```
- on your browser
```
node-ip:node-port
```
  - if this fail you can forward the service port to a port on your local host, that way you can access the service from your localhost port.
  - to forward the service port to your local host port, use
    ```
    kubectl port-forward service/result 5001:5001 &
    ```
  - this will forward the service port 5001 to your local host port 5001
  - you can then access the `service` service on your browser via **`localhost:5001`**
  - to stop the port forwarding, use the command **`jobs`** to get the job id, then use the **`kill`** command to kill the job
    ```
    kill %1
    ```
- in order to simplify creation of resources, we can modify the yaml files to acheieve that.
- first delete all the resources in yoour namespace
  ```
  kubectl delete deployment,pod,service --all
  ```
- verify if there's any resource in your ns
  ```
  kubectl get all
  ```
- in the **`k8s-spcecifications`** directory, create 2 files
    - deployments.yaml
    - services.yaml
- create 2 directories
    - **`deployments`**
    - **`services`**
- modify the contents of the **`deployments.yaml`** file. see [deployments.yaml](assignment_resources/deployments.yaml) for details
- modify the contents of the **`services.yaml`** file in similar manner. see [services.yaml](assignment_resources/services.yaml)
- move the individual deployments to the deployment directory
- do similar thing for the services
- modify the port numbers if you wish to
- run the the command to create all the deployments
  ```
  kubectl create -f deployments.yaml
  ```
- create the services
- if you can't access the services from your browser using the `node-ip:nope-port` forward the service ports to your local host and use `localhost:localhost-port` to access the service.
- to stop your minikube node, run `minikube stop`

### HAPPY LEARNING.


     