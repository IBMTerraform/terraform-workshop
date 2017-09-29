#!/bin/sh
if [ -z $KUBECONFIG ];
then
  echo "No KUBECONFIG set, using local install"
fi

#kubectl delete -f cat.yaml
#kubectl delete -f cart.yaml
#kubectl delete -f ui.yaml
#kubectl delete -f ingress.yaml

# deploy: use 'envsubst' command to replace environment variables within the deployment script.
#kubectl create -f cat.yaml
#kubectl create -f cart.yaml
#kubectl create -f ui.yaml
cat ./cat.yaml | envsubst | kubectl apply -f - --validate
cat ./cart.yaml | envsubst | kubectl apply -f - --validate
cat ./ui.yaml | envsubst | kubectl apply -f - --validate
cat ./ingress.yaml | envsubst | kubectl apply -f - --validate
