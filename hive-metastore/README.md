kubectl create configmap metastore-cfg -n presto --dry-run --from-file=metastore-site.xml --from-file=core-site.xml -o yaml | kubectl apply -f -
