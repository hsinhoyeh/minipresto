
kubectl create configmap presto-cfg -n presto --dry-run --from-file=config.properties.coordinator --from-file=config.properties.worker --from-file=node.properties.template --from-file=hive.properties.template -o yaml | kubectl apply -f -
