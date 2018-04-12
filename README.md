# infrastructure
battlesnake infrastructure

#### infrastructure design:

The Battlesnake infrastructure is designed around Google Cloud Platform and Terraform.

We tried to stay simple and to leverage Google Cloud Platform products.

You will find the different Terraform modules under the folder [modules](/modules)


![infra design](/img/infra_diagram.png)

#### Pre Requirements:
Install Google SDK [https://cloud.google.com/sdk/] and login to retrive your credentials
```
gcloud auth login
```



In Google Cloud Platform create a project, for example named `administration`, and create a Browser bucket. This bucket is needed to store the Terraform states. Edit the different references of the bucket named `terraform-states-battlesnakeio` in the code with the name of your bucket.

<!-- TODO create the battlesnake script -->
<!-- If you are going to deploy locally or without using the main script `./battlesnake` you will need the following tools installed on your computer:
- helm [https://github.com/kubernetes/helm]
- Terraform [https://www.terraform.io/] -->


#### Needs to be apply on the GKE cluster:

Open a terminal where you have kubectl and your gke credentials installed:

This is to allow to create RBAC features:
```
kubectl create clusterrolebinding cluster-admin-binding \
    --clusterrole cluster-admin --user $(gcloud config get-value account
```

If you are going to use helm and Tiller to deploy kubernetes charts and manifests you will need to do the 3 next commands:
```
kubectl create serviceaccount --namespace kube-system tiller
```

```
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin       --serviceaccount=kube-system:tiller
```

```
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
```