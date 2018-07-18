# infrastructure
battlesnake infrastructure

#### infrastructure design:

The Battlesnake infrastructure is designed around Google Cloud Platform, Terraform, Kubernetes and Docker.

We tried to stay simple and to leverage Google Cloud Platform products.

You will find the different Terraform modules under the folder [modules](/modules)


![infra design](/img/infra_diagram.png)

#### Pre Requirements:
- Google SDK [https://cloud.google.com/sdk/] and login to retrive your credentials.
```
gcloud auth login
```

- kubectl [https://kubernetes.io/docs/tasks/tools/install-kubectl/]

- helm [https://github.com/kubernetes/helm]

- helm template [https://github.com/technosophos/helm-template]
```
helm plugin install https://github.com/technosophos/helm-template
```
- Terraform [https://www.terraform.io/]


- In Google Cloud Platform create a project, for example named `battlesnake-io`, and create a Browser bucket name `terraform-battlesnake-io`. This bucket is needed to store the Terraform states. 

- In the same project create a Service Account, and give it the Project Owner rights.

#### Deploy the infrastructure in your Google Cloud Platform account
We will now start the deployment of the infrastructure with the Terraform code. In a existing project:

- In Google Cloud Platform, go to Compute Engine, under metadata click on SSH Keys and add a ssh key that will be applied to all the instances at the project level.
- setup application default credentials `gcloud auth application-default login`

- In a shell, go to the folder [/gcp/us-west1/production/base](gcp/us-west1/production/base) and do a `terraform init`. This will fetch the modules in the [/modules/gcp](modules/gcp) folder and initialize the bucket backend. Now do a `terraform apply`, it will generate a plan of the actions that will take place and will ask if yes or no you wan to apply those changes. If you are ok with the changes, answer yes and wait until Terraform finishes creating the resources.

- Do the same steps than previously in the folders:
    - [/gcp/us-west1/production/network](gcp/us-west1/production/network)
    - [/gcp/us-west1/production/k8s](gcp/us-west1/production/k8s)

- In Google Cloud Platform, go to Kubernetes Engine and click on connect to get the shell command to setup the authentication to your newly created cluster, this should look something like this:

```
export CLOUDSDK_CONTAINER_USE_V1_API_CLIENT=false && export CLOUDSDK_CONTAINER_USE_V1_API=false && gcloud beta container clusters get-credentials battlesnake-k8s-gke --region us-west1 --project battlesnake-123456
```

-  Do a `terraform init` and `terraform apply` in the following folders:
    - [/gcp/us-west1/production/sql](gcp/us-west1/production/sql) 
    - [/gcp/us-west1/production/k8s_secrets](gcp/us-west1/production/k8s_secrets)

- We are now setting up RBAC resources:

```
kubectl create clusterrolebinding cluster-admin-binding \
    --clusterrole cluster-admin --user $(gcloud config get-value account)
```
```
kubectl create clusterrolebinding --user system:serviceaccount:kube-system:default \
    kube-system-cluster-admin --clusterrole cluster-admin
```

This is to allow Tiller to work:

```
kubectl create serviceaccount --namespace kube-system tiller
```

```
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
```

```
helm init
```

```
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
```


- In Google Cloud Platform, go to Cloud DNS and Create a new zone with the domain that you want to use. Follow the Cloud DNS instruction to setup your registar. We need this only if we want to use the external-dns feature of Kubernetes, which will create automaticly DNS records based on either an annotation for a service in k8s or by the host value in an ingress.

- We will use nginx-controller to manage our ingress resources, go to the charts folder and do:
```
helm install --name nginx-controller nginx-controller --namespace kube-system
```

- We need to deploy external-dns to manage our dns entries automatically:
```
helm install --name external-dns stable/external-dns --namespace kube-system --set google.project=battlesnake-io,provider=google,domain-filter=battlesnake.io,source=ingress,registry=txt,txt-owner-id=battlesnake-io,policy=sync
```

- We now deploy cert-manager which will generate lets encrypt certificate and manage their lifecycle:
```
helm install --name cert-manager stable/cert-manager --namespace kube-system --set ingressShim.extraArgs='{--default-issuer-name=letsencrypt-prod,--default-issuer-kind=ClusterIssuer}'
```
Go to the cert-manager folder in charts then do:
```
kubectl apply -f clusterissuer.yaml
```

#### Deploy the test app

Go to the charts folder and do:
```
helm install --name test test --set domain=yourdomain.com
```
