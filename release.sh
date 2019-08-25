#!/bin/bash

dotnet build --runtime linux-x64 mongo.csproj
dotnet publish --runtime linux-x64
docker build --tag mongo-load:$1 .
