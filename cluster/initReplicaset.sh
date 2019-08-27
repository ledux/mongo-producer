#!/bin/bash

if [ $# -lt 1 ]; then
  echo "Provide the number of replicas"
  echo "$0 <number>"
  exit 1
fi

# replicaset=$(ps aux | grep -oP '(?<=--replSet\s)\w+')
replicaset=rs0
hostname=$(hostname -f)
numberofreplicas=$1

echo "rs.initiate({_id: \"$replicaset\", version: 1, members: [" > initReplicas.js
for (( i=0; i<$numberofreplicas; i++ )); do
  host=$(echo $hostname | sed -r "s/[0-9]/$i/")
  echo "{ _id: $i, host: \"$host:27017\" }," >> initReplicas.js
done
echo "]});" >> initReplicas.js
