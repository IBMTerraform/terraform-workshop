#!/bin/sh
DBURL=$1
echo $DBURL

curl -X PUT $DBURL/products
echo RC=$?
curl -X PUT $DBURL/categories
echo RC=$?
echo curl -d @./categories.json -X POST -H 'Accept: application/json' -H 'Content-Type:application/json' $DBURL/categories/_bulk_docs
curl -d @./categories.json -X POST -H 'Accept: application/json' -H 'Content-Type:application/json' $DBURL/categories/_bulk_docs
echo RC=$?
echo curl -d @./products.json -X POST -H 'Accept: application/json' -H 'Content-Type:application/json' $DBURL/products/_bulk_docs
curl -d @./products.json -X POST -H 'Accept: application/json' -H 'Content-Type:application/json' $DBURL/products/_bulk_docs
echo RC=$?
