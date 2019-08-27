#!/bin/bash

if [ $# -lt 1 ]; then
  echo "Provide a namespace for the secret"
  echo "$0 <namespace>"
  exit 1
fi

tempfile=$(mktemp)
/usr/bin/openssl rand -base64 741 > $tempfile
kubectl create secret generic mongo-replica-auth --from-file=internal-auth-keyfile=$tempfile
rm $tempfile

