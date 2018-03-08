#!/bin/sh
if [ -z $KUBECONFIG ];
then
  echo "No KUBECONFIG set, using local install"
fi
DIR=`dirname $0`

#kubectl delete -f ./$DIR/cat-free.yaml
#kubectl delete -f ./$DIR/cart-free.yaml
#kubectl delete -f ./$DIR/gateway-free.yaml
#kubectl delete -f ./$DIR/website-free.yaml
#kubectl delete -f ./$DIR/ship-free.yaml

# deploy: use 'envsubst' command to replace environment variables within the deployment script.
perl -p -i -e 's/\$\{([^}]+)\}/defined $ENV{$1} ? $ENV{$1} : $&/eg' < ./$DIR/cat-free.yaml | kubectl apply -f - --validate
perl -p -i -e 's/\$\{([^}]+)\}/defined $ENV{$1} ? $ENV{$1} : $&/eg' < ./$DIR/cart-free.yaml | kubectl apply -f - --validate
perl -p -i -e 's/\$\{([^}]+)\}/defined $ENV{$1} ? $ENV{$1} : $&/eg' < ./$DIR/gateway-free.yaml | kubectl apply -f - --validate
perl -p -i -e 's/\$\{([^}]+)\}/defined $ENV{$1} ? $ENV{$1} : $&/eg' < ./$DIR/website-free.yaml | kubectl apply -f - --validate
