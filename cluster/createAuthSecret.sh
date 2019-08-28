#!/bin/bash
# creates a secret from a random base65 string

if [ $# -lt 1 ]; then
  echo "Provide a namespace for the secret"
  echo "$0 <namespace>"
  exit 1
fi

tempfile=$(mktemp)
namespace=$1
secretname=mongo-replica-auth
filename=internal-auth-keyfile
# create some random base64 encoded string into the tempfile
/usr/bin/openssl rand -base64 741 > $tempfile

# create a secret from this random string in the K8s cluster.
echo "Creating secret in namespace $namespace with name $secretname and filename $filename"
kubectl -n $namespace create secret generic $secretname --from-file=$filename=$tempfile

rm $tempfile

