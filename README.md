# infrastructure
battlesnake infrastructure

#### infrastructure design:

The Battlesnake infrastructure is designed around Google Cloud Platform and Terraform.

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


- In Google Cloud Platform create a project, for example named `administration`, and create a Browser bucket. This bucket is needed to store the Terraform states. Edit the different references of the bucket named `terraform-states-battlesnakeio` in the code with the name of your bucket.

- In the same project create a Service Account, and give it the Organization Administrator and Owner.

#### Deploy the infrastructure in your Google Cloud Platform account
We will now start the deployment of the infrastructure with the Terraform code.

- In a shell, go to the folder [/gcp/base](/gcp/base) and do a `terraform init`. This will fetch the modules in the [/modules/gcp](/modules/gcp) folder and initialize the bucket backend. Now do a `terraform apply`, it will generate a plan of the actions that will take place and will ask if yes or no you wan to apply those changes. If you are ok with the changes answer yes and wait until Terraform finish to create the ressources.

- In Google Cloud Platform, go to Compute Engine, under metadata click on SSH Keys and add a ssh key that will be applied to all the instances at the project level.

- Do the same steps than step 1 in the folder [/gcp/network](/gcp/network).


- Do the same steps than step 1 in the folder [/gcp/k8s](/gcp/k8s).

- In Google Cloud Platform, go to Kubernetes Engine and click on connect to get the shell command to setup the authentication to your newly created cluster, this should look something like this:

```
export CLOUDSDK_CONTAINER_USE_V1_API_CLIENT=false && export CLOUDSDK_CONTAINER_USE_V1_API=false && gcloud beta container clusters get-credentials battlesnake-k8s-gke --region us-west1 --project battlesnake-123456
```

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
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
```

```
helm init
```

- In Google Cloud Platform, go to Cloud DNS and Create a new zone with the domain that you want to use. Follow the Cloud DNS instruction to setup your registar. We need this only if we want to use the external-dns feature of Kubernetes, which will create automaticly DNS records based on either an annotation for a service in k8s or by the host value in an ingress.

- We will use nginx-controller to manage our ingress resources, go to the charts folder and do:
```
helm install --name nginx-controller nginx-controller --namespace kube-system
```

- We need to deploy external-dns to manage our dns entries automaticly:
```
helm install --name external-dns stable/external-dns --namespace kube-system --set google.project=yourgoogleprojectid,provider=google,domain-filter=yourdomain.com,source=ingress,registry=txt,txt-owner-id=my-identifier,policy=sync
```

- We now deploy cert-manager which will generate lets encrypt certificate and manage their lifecycle:
```
helm install --name cert-manager stable/cert-manager --namespace kube-system --set ingressShim.extraArgs='{--default-issuer-name=letsencrypt-prod,--default-issuer-kind=ClusterIssuer}'
```
Go to the charts folder change the email value in the file `clusterissuer.yaml` then do:
```
kubectl apply -f clusterissuer.yaml
```

#### Deploy the test app

Go to the charts folder and do:
```
helm install --name test test --set domain=yourdomain.com
```
