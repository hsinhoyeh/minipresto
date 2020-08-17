## Mini-Presto


Mini-Presto is a presto cluster hosted on top of minikube on multiple node environment (single instance but multiple virtual nodes).

In this example, we deployed one presto cluster (including two presto nodes and one coordinator) and one hive-metastore (backed by maria db). And use AWS S3/ GCS as its data lake storage.

### installation

#### kubectl

```
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl
```

#### minikube

```
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v1.12.3/minikube-linux-amd64
chmod +x minikube
mv minikube /usr/local/bin/
```


#### Initialize minikube

```
minikube start --nodes 3 \
--kubernetes-version v1.18.0 \
--enable-default-cni=false \
--network-plugin=cni \
--extra-config=kubeadm.pod-network-cidr=10.244.0.0/16
```

NOTE: You have to turn-off default cni otherwise nodes are unable to communicate each other.

#### Create presto namespace

```
kubectl create ns presto
```

and setup each services under folders.


### Usage


####  via presto-cli
```
kubectl exec -it presto-cli -n presto -- /bin/bash

/opt/presto-cli --server presto:8080 \
--catalog hive \
--schema default

CREATE SCHEMA hive.tpcds WITH \
(location = 'gs://<bucketname>/tpcds/');

CREATE TABLE tpcds.store_sales \
AS SELECT * FROM tpcds.sf100.store_sales;

select count(*) from tpcds.store_sales;
  _col0
---------
 2880404
(1 row)
```


#### Reference
[1] https://github.com/joshuarobinson/presto-on-k8s
