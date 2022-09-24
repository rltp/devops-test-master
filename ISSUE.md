# Cloud/DevOps Technical Test

This test aims to evaluate your Kubernetes / Cloud Engineering skills. You will have to provide a documented Github project with any command lines or code that you produced and your answers.

Requirements:
- [Docker](https://www.docker.com/get-started)
- A Kubernetes cluster (You can deploy one locally using [Minikube](https://minikube.sigs.k8s.io/docs/start/))

## 1. Deploying an Application to Kubernetes

Our web team just developed a new Python API and we'd like to deploy it to our Kubernetes Cluster. This API is based on [FastAPI](https://fastapi.tiangolo.com/) and relies on a [MongoDB](https://docs.mongodb.com/) database.

You will find the application source code in `./resources/sample-api`.

- Create a Dockerfile for this API.
- Deploy this API and a persistent MongoDB database to Kubernetes.
- Deploy an ephemeral HTTP client and interract with the API from your cluster. (Note that the API exposes a Swagger documentation on `/docs` explaining how to interract with it).

### 1.1 Create Dockerfile
The simple-api application contains some of information in the Pipfile like the Python version (3.8).
Pipfile is a configuration file used by the Pipenv module, and in the case replace the requirement file.
````sh
    $ python -m pip install --upgrade pip
    $ pip install pipenv
    $ pipenv install --system --deploy
````
Also we need to download and install pipenv module with pip command.
We found in the uvicorn module who is a Server Gateway Interface to provisionning the API interface with the host. We can launch the application with the following command (<ins>only as root user</ins>): 
````sh
    $ pipenv shell  
    $ uvicorn app.main:app --host 0.0.0.0 --port 80
````
- App target argument identify with attribute throw the module path refers
- Host argument is required for this case and must set to 0.0.0.0 because we need to have a non-retouable address
- Port argument specify wich port must be open on the host, as is web server and communicate with user browser we use the HTTP protocol (known as 80 port).

Once the docker file its created, let's go to build it with the following command.
```sh
    $ docker build --network=host -t untienots/sample-api .
```
In my case I don't have a virtual machine with *nix, also used the WSL2 with ubuntu, so I need to specify with network driver I used to access to internet for download.
And don't forget to make a port forwarding rules with Windows and WSL2 as follows.

```cmd
    netsh interface portproxy add v4tov4 listenport=80 listenaddress=0.0.0.0 connectport=80 connectaddress=172.17.221.164
```

Finally run the built image, test it and read the Swagger documentation.
```sh
    $ docker run -p 80:80 untienots/sample-api
```
A bash file automated the procedure, refers to `./utils/1.1.0_build_sample-api.sh`

### 1.2 Deploy simple-api and persistent mongoDB on k8s
Refers to the files bash created into the utils folders.

Firstly we create a namaspace on k8s, `devops-test-master` (`./utils/0_apply_namespace.sh`)
Apply sample-api pod on this namespace (`./utils/1.1.1_apply_sample-api.sh`)
Install mongodb image on minikube (`./utils/1.2.0_install_mongo_image.sh`)
Create a persistant mongodb instance which required a persistantVolume, also it needs a Storage Class, a PV claim (`./utils/1.2.1_apply_mongo.sh`)

#### Why choosing a Deployment not a Stateful ressource ?
A deployment is a Kubernetes object which is preferred when deploying a stateless application or when multiple replicas of pods can use the same volume.
A stateful set is a Kubernetes object which is preferred when we require each pod to have its own independent state and use its own individual volume.
Another major difference between them is the naming convention for pods. In the case of deployments, pods are always assigned a unique name but this unique name changes after the pod are deleted & recreated.
Here, in this example we are deploying a standalone MongoDB instance, therefore – we can use a deployment object. This is because only one pod will be spun up.

### 1.3 Deploy an ephemeral HTTP client and interract with the API from your cluster

The ephemeral HTTP client consist of an alpine image with curl installed and a bash script that generate random users and POST each on sample-api route `/users/`.
Very simple not complex, and can be build using the `./utils/1.3.0_build_http-client.sh`

Once image build and accessible from the docker registery we can apply the http-client pod using the bash file `./utils/1.3.1_apply_http-client.sh`

```sh
    $ kubectl exec -i -t -n devops-test-master http-client-pod -c http-client -- sh -c "clear; (bash || ash || sh)"
    $ ./generate_user.sh
```

Port forwarding the `api-service-node` service on the port 80 to 7777
```sh
    $ kubectl port-forward service/api-service-node 80:7777
```
Open the you navigator on the follow URL http://localhost:7777/users/ and Voilà

If you want to automate all this section on your lab you can just start the `./utils/all_in_one.sh` bash file.

## 2. Moving to production
We now want to move this application into a production cluster running multiple other applications. This application handles sensible data and we have to protect ourselves from data leaks.

- We need to provision a DNS domain and SSL Certificates for our API in production, what tools can we use to automate that process? Can you explain how they work?

Moving workloads to production environment need to have prerequirements like seprate namespaces
1 - Installing of ingress controller like nginx-ingress for example with static external IP
2 - Generating certificate ssl with cert-manager CRD for example and setting-up with wildcard or self-signed certificate
    (Best pratice is to use a tierce-signed certificate)
3 - Installing and configuring an DNS controller like ExternalDNS for example
    (Don't forget to create a service account resource in k8s)
4 - redeploying the sample-api with SSL enabled public endpoint

- How can we make sure that our Docker images running in production are secure? What security risks are we exposed to if we run any images we find in production?

We cannot say everything is secure, there are always security risks. However some bests practices can be enable.
1 - Use policy enforcement across the stack container like OPA for example 
2 - Create namespace policy to control traffic flow and isolate it


- This API and it's database handles sensible data, what security measure can we implement to isolate them from other applications? How would you limit the risk of data exfiltrations? Improve your Kubernetes deployment to take into account those security measures, and deploy it to your cluster.

Use x.509 certificates to authenticate clients, not username/password auth like in this labs

## 3. Migrate a Kubernetes Cluster
We need to recreate our production clusters to enable some security features, while minimizing the downtime on this API. Can you elaborate a migration process?
