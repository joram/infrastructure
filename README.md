# infrastructure
battlesnake infrastructure

#### infrastructure design:

The Battlesnake infrastructure is designed around Google Cloud Platform and Terraform.

We tried to stay simple and to leverage Google Cloud Platform products.

You will find the different Terraform modules under the folder [modules](/modules)


![infra design](/img/infra_diagram.png)

#### Pre Requirements:
- Google SDK [https://cloud.google.com/sdk/] and login to retrive your credentials
```
gcloud auth login
```

- helm [https://github.com/kubernetes/helm]
- helm template [https://github.com/technosophos/helm-template]
```
helm plugin install https://github.com/technosophos/helm-template
```
- Terraform [https://www.terraform.io/]


In Google Cloud Platform create a project, for example named `administration`, and create a Browser bucket. This bucket is needed to store the Terraform states. Edit the different references of the bucket named `terraform-states-battlesnakeio` in the code with the name of your bucket.


#### Needs to be apply on the GKE cluster:

Open a terminal where you have kubectl and your gke credentials installed:

This is to allow the creation of RBAC features:
```
kubectl create clusterrolebinding cluster-admin-binding \
    --clusterrole cluster-admin --user $(gcloud config get-value account
```

If you are going to use helm and Tiller to deploy kubernetes charts and manifests you will need to pass the 3 next commands:
```
kubectl create serviceaccount --namespace kube-system tiller
```

```
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin       --serviceaccount=kube-system:tiller
```

```
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
```