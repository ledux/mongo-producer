#!/bin/bash

if [ $# -lt 1 ]; then
  echo "Provide the total  number of replicas (primary + secondaries)"
  echo "$0 <number>"
  exit 1
fi

# replica set is read from the start up command of the container.
# There is a parameter called --replSet <replicaset-name> where the name of the replica set is provided.
replicaset=$(ps aux | grep -oP '(?<=--replSet\s)\w+')
# The fully qualified host name is needed to find the other replica sets
hostname=$(hostname --fqdn)
# The number of total replica sets needs to be provided as parameter
numberofreplicas=$1
# The name of the js command which will be sent to mongo.
replicaCommandFile=initReplicas.js

echo "rs.initiate({_id: \"$replicaset\", version: 1, members: [" > $replicaCommandFile
for (( i=0; i<$numberofreplicas; i++ )); do
  host=$(echo $hostname | sed -r "s/[0-9]/$i/")
  echo "{ _id: $i, host: \"$host:27017\" }," >> $replicaCommandFile
done
echo "]});" >> $replicaCommandFile

# mongo $replicaCommandFile

# rm $replicaCommandFile


