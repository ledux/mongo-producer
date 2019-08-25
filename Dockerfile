FROM microsoft/dotnet:2.2.0-runtime
WORKDIR /app
COPY bin/Debug/netcoreapp2.2/linux-x64/publish .

ENTRYPOINT dotnet mongo.dll