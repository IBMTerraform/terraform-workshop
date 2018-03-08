#!/bin/sh
if [ -z $KUBECONFIG ];
then
  echo "No KUBECONFIG set, using local install"
fi

kubectl delete -f ./$DIR/cat.yaml
kubectl delete -f ./$DIR/cart.yaml
kubectl delete -f ./$DIR/gateway.yaml
kubectl delete -f ./$DIR/website.yaml
kubectl delete -f ./$DIR/ingress.yaml
#kubectl delete -f ./$DIR/ship-free.yaml

# deploy: use 'envsubst' command to replace environment variables within the deployment script.
cat ./$DIR/cat.yaml | envsubst | kubectl apply -f - --validate
cat ./$DIR/cart.yaml | envsubst | kubectl apply -f - --validate
cat ./$DIR/gateway.yaml | envsubst | kubectl apply -f - --validate
cat ./$DIR/website.yaml | envsubst | kubectl apply -f - --validate
cat ./$DIR/ingress.yaml | envsubst | kubectl apply -f - --validate
#cat ./$DIR/ship-free.yaml | envsubst | kubectl apply -f - --validate
