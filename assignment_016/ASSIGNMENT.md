## DevOps Journey: Metrics-server, HPA, VPA, Prometheus

**stop minikube and start again enabling API aggregation layer**
    ```
    minikube start --extra-config=apiserver.enable-aggregator-routing=true
    ```
**Install a metrics server on your cluster with a manifest file**
    - if you're running in the cloud, you can install the metric-server by running 
        ```
        $ kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
        ```
    - if you're running locally, consider using the [metrics-server.yaml](https://github.com/michaelkedey/k8s/blob/main/helm/pod_scalling/metrics-server/metrics-server.yaml) file.
        ```
        $ kubectl apply -f metrics-server.yaml
        ```
    - if you run into `readines probe failed` error for the `metrics-server pods` while using the first option, consider using the [metrics-server.yaml](https://github.com/michaelkedey/k8s/blob/main/helm/pod_scalling/metrics-server/metrics-server.yaml) file to deploy the [metrics-server](https://github.com/michaelkedey/k8s/blob/main/helm/pod_scalling/metrics-server/components.yaml) locally.
**You can also install a metrics server on your cluster with helm**
    - install metrics-server
        ```
        helm install my-metrics-server oci://registry-1.docker.io/bitnamicharts/metrics-server --namespace kube-system
        ```
        - if you get an error about existing resources such as `service acount`, probably from creating the metrics server from the first option earlier, delete the resources and run the helm installation again.
          ```
          kubectl delete sa metrics-server -n kube-system
          kubectl delete svc metrics-server -n kube-system
          kubectl delete apiservice v1beta1.metrics.k8s.io
          ```
        - if your metrics server pods are failing livenes and readines probes, consider upgrading/installing the metrics server with these [custom-metrics-server-values.yaml](https://github.com/michaelkedey/k8s/blob/main/helm/pod_scalling/metrics-server/metrics-server-values.yaml) file 
          ```
          helm upgrade --install the-metrics-server the-metrics-server/metrics-server -n kube-system -f /d/code/k8s/metrics-server-values.yaml
          ```
    - you may have to restart `minikube` anmog other troubleshooting methods, if you're encountering issues.


**Install `hpa`**  
    - you can run the following code to generate a simple hpa on your cluster
        ```
        kubectl autoscale deployment name-of-your-deployment --cpu-percent=50 --min=1 --max=10
        ```
    - you can also create and install an enhanced `hpa` like [this hpa](https://github.com/michaelkedey/k8s/blob/main/helm/pod_scalling/hpa/vote-app-chart/templates/hpa/hpa.yaml) defined in `helm` for the [vote-app](https://github.com/michaelkedey/example-voting-app).
    - you can also define an `hpa` in a manifest file and deploy via `kubectl` [like this](https://github.com/michaelkedey/k8s/blob/main/pod_scalling/hpa/hpa.yaml)
        ```
        kubectl apply -f hpa.yaml
        ```
    - for each `deploy` in the [vote-app](https://github.com/michaelkedey/example-voting-app) create an hpa to monitor and scale the pods as necessary.
    - check scalling history
        ```
        kubectl describe hpa my-app-hpa
        ```
  
**Install `vpa`**  
    - git clone this repo and run the script to set the cutom resource definitions needed for hpa installation
        ```
        git clone https://github.com/kubernetes/autoscaler.git
        ```
        - run script
        ``` 
        cd autoscaler/vertical-pod-autoscaler/hack
        ./vpa-up.sh
        ``` 
    - you can create and install an enhanced `vpa` like [this vpa](https://github.com/michaelkedey/k8s/blob/main/helm/pod_scalling/vpa/vote-app-chart/templates/vpa/vpa.yaml) defined in `helm` for the [vote-app](https://github.com/michaelkedey/example-voting-app).
    - you can also define an `vpa` manifest file and deploy via `kubectl` like [this vpa](https://github.com/michaelkedey/k8s/blob/main/pod_scalling/vpa/vpa.yaml)
        ```
        kubectl apply -f vpa.yaml
        ```
**install prometheus**
    - add the `prometheus` repo to helm
        ```
        helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
        ```
    - update helm repo
    - install the `prometheus` chart
        ```
        $ helm install prometheus-stack prometheus-community/kube-prometheus-stack --namespace monitoring --create-namespace --set alertmanager.persistentVolume.storageClass="gp2",server.persistentVolume.storageClass="gp2"
        ```
    - yuou can use `lens` to forward the `prometheus-stack-grafana` `svc` and access it from outside of your cluster.
    - defualt username is `admin`
    - you cab use `lens` or `kubectl` to get the password 
        ```
        kubectl get secret prometheus-stack-grafana -n monitoring -o yaml
        ```
        - decode the encrypted username and password to get your login details
            ```
             echo cHJvbS1vcGVyYXRvcg== | base64 -d
            ```
    - on the prometheus web console, navigate to `dashboards` and select `Alertmanager / Overview` to have an overview of your node
    - explore other functions on the console.
    - you can click on the plus icon, to import new dashboards to monitor your cluster.
        - navigate to `https://grafana.com/grafana/dashboards` and download some publicly available dahsboards.
            - Pod Stats & Info
            - Pod Statistic (Karpenter)


### HAPPY LEARNING
