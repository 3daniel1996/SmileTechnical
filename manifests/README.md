# Kubernetes Setup for Project Smile

This guide provides step-by-step instructions to set up a Kubernetes cluster for Smile, including updating the deployment image, configuring connectivity, and deploying resources.

## Prerequisites

- AWS CLI installed and configured
- kubectl installed
- AWS EKS cluster named 'smile' created

## Steps

### 1. Update Deployment Image

Update the Docker image in your Kubernetes deployment at /manifests/deployment.

```bash
image: <AWSACCOUNTNUMBER>.dkr.ecr.us-east-1.amazonaws.com/smile:latest
```

### 2. Update kubeconfig

Update kubeconfig with the below command

```bash
aws eks update-kubeconfig --region us-east-1 --name smile
```

### 3. Run the following commands to run the Kubernetes HelloSmile API

```bash
kubectl create namespace smile
cd manifests
kubectl apply -f .
```

### 3. Test
To test the API run the below command and paste the external-IP in a Browser
```bash
kubectl get service --namespace=ingress
```


