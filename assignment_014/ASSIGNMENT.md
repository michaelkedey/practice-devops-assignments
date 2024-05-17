## DevOps Journey: Containerization and Orchestration

#### Set Up Your Environment
- install [Docker Desktop](https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe?utm_source=docker&utm_medium=webreferral&utm_campaign=dd-smartbutton&utm_location=module)
- install [Lens](https://api.k8slens.dev/binaries/Lens%20Setup%202024.4.230844-latest.exe) to easily manage your pods via gui
- install **`Kubernetes-cli`**
    ```
    choco install kubernetes-cli
    ```
- install **`Minikube`**
  ```
  choco install minikube
  ```
- start the minikube cluster
  ```
    minikube start
    ```
- set up your environemnt, and start **`Lens`**
    - by default, lens should be able to identify your minikube cluster.
    - if not, go through the process of adding a new cluster and add minikube

### Containerization with Docker
- fork the [example-voting-app](https://github.com/michaelkedey/example-voting-app/fork) repository if you don't have one already.
- clone the [example-voting-app](https://github.com/michaelkedey/example-voting-app/fork) source code repository from the fork you created.
  eg.
  ```
  git clone https://github.com/michaelkedey/example-voting-app.git
  cd example-voting-app
  ```
- alternatively you can also fork and clone [this repo](https://github.com/nuviagithub/example-voting-app/fork)

- navigate to the **`k8s-specifications`** directory
- create a new directory caled **`vote-app`** and define a k8s manifest file similar to [vote-app.yaml](assignment_rsources/vote-app.yaml) in it.
    - you can modify the file to use your own existing docker images
    - you can change the ports as well as other details
    - if you need to build the images from scratch, refer to [assignment_013](../assignment_013/)
- push your changes to go github
  ```
  git add .
  git commit -m "commit message"
  git push origin main
  ```
- on your local environemt, install **`argoCD`** in a dedicated namespace, to help with easy deployments
    - create a namespace
        ```
        kubectl create namespace argocd
        ```
    - install argoCD in the argocd namespace you created
        ```
        kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
        ```
- Using Lens, select the **`argocd`** ns, and click on services.
- port forward the **`argocd-server`** service and access the web interface from outside of the cluster
- to sign in
    - username: admin
    - password
        - to get the initial password, run
        ```
        kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
        ``` 
- on sign in, you can update the user password
- to create an application, click on **applications --> new app**
    - you can proceed to create the app via gui or edit as yaml
    - if you edit via yaml, you can creat a file similar to [this](assignment_resources/argo_cd.yaml) and watch the gui fields populate with the details of the yaml file.
        - you can modify the source with your own github repo, provided it has all the manifest files
        - also modify the path to the manifest file where necessary
    - click on create when done.
- click on the new application and view the details
- in lens, select the namespace deffined in the argo cd application, and view the pods, deploymenys and svcs
- to access the vote and result svc, port foward these two svcs in lens


### GAMES

- in the `k8s` directory, create another directory called games, and specify a [yaml manifest](assignment_resources/tetris.yaml) file for deploying a tetris image.
    - see [tetris.yaml](assignment_resources/tetris.yaml)
- push your changs to github and use argocd to create the tetris application.
- create manifest files to deploy these images via argocd
    - sevenajay/mario
    - chriscloudaz/netflix
    - remember to push your changes to github and build with argocd

























