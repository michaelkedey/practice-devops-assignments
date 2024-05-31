## DevOps Journey: Helm Chart, RBAC.
- **[Fork](https://github.com/michaelkedey/k8s/fork) or [clone](https://github.com/michaelkedey/k8s) this [k8s repo](https://github.com/michaelkedey/k8s)**

**Generate a helm chart to deploy the [vote-app](https://github.com/michaelkedey/example-voting-app) after forking and cloning the [vote-app](https://github.com/michaelkedey/example-voting-app) repo**

- refer to [this k8s repo](https://github.com/michaelkedey/k8s) on how to structure your helm chart

- you can create a new repo for the chart like [this k8s repo](https://github.com/michaelkedey/k8s), or create a new directory inside the [vote-app](https://github.com/michaelkedey/example-voting-app) directory
- install helm
  - windows
    - if you have [chocolatey](https://chocolatey.org/install) installed in your windows environment
    - open `powershell` as an administrator and run this command
    ```
      choco install kubernetes-helm -y
    ```
  - linux (debian/ubuntu)
    ```
        sudo apt-get install helm
    ```  
  - mac
    ```
        brew install helm
    ```
- check helm version
```
    helm version
``
- generate chart
    ```
    helm create vote-app
    ```
- include volumes for for the appropriate pods
    - db (postgress)
    - redis 
- include service account for the pods
- include RBAC for the pods
    - roles
    - role bindings
- include a `secrets file` for any environemnt secrets
    - db user
    - db password
- be sure to not use any hard-coded values in your template files, make use of the values files
- deploy your application by running
    ```
    helm install release-name (path to)chart-name
    ```
    - eg.
        ```
        helm install version1 vote-app
        ```
- use `helm list` to see all your helm releases running
- use `helm status release-name` to see the status of your helm release
- use `helm delete release-name` to delete your helm release

### HAPPY LEARNING