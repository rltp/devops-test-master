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


## 2. Moving to production
We now want to move this application into a production cluster running multiple other applications. This application handles sensible data and we have to protect ourselves from data leaks.

- We need to provision a DNS domain and SSL Certificates for our API in production, what tools can we use to automate that process? Can you explain how they work?

- How can we make sure that our Docker images running in production are secure? What security risks are we exposed to if we run any images we find in production?

- This API and it's database handles sensible data, what security measure can we implement to isolate them from other applications? How would you limit the risk of data exfiltrations? Improve your Kubernetes deployment to take into account those security measures, and deploy it to your cluster.

## 3. Migrate a Kubernetes Cluster
We need to recreate our production clusters to enable some security features, while minimizing the downtime on this API. Can you elaborate a migration process?
