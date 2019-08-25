#!/bin/bash

dotnet build --runtime linux-x64 mongo.csproj
dotnet publish --runtime linux-x64
docker build --tag tacsreg.azurecr.io/mongo-load:$1 .
docker push tacsreg.azurecr.io/mongo-load:$1
