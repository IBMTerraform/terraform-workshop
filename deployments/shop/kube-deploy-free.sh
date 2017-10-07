#!/bin/sh
if [ -z $KUBECONFIG ];
then
  echo "No KUBECONFIG set, using local install"
fi
DIR=`dirname $0`

kubectl delete -f ./$DIR/cat-free.yaml
kubectl delete -f ./$DIR/cart-free.yaml
kubectl delete -f ./$DIR/gateway-free.yaml
kubectl delete -f ./$DIR/website-free.yaml
#kubectl delete -f ./$DIR/ship-free.yaml

# deploy: use 'envsubst' command to replace environment variables within the deployment script.
cat ./$DIR/cat-free.yaml | envsubst | kubectl apply -f - --validate
cat ./$DIR/cart-free.yaml | envsubst | kubectl apply -f - --validate
cat ./$DIR/gateway-free.yaml | envsubst | kubectl apply -f - --validate
cat ./$DIR/website-free.yaml | envsubst | kubectl apply -f - --validate
#cat ./$DIR/ship-free.yaml | envsubst | kubectl apply -f - --validate
