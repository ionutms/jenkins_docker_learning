# jenkins_docker_learning

# Installation
## Build the Jenkins BlueOcean Docker Image
```
docker build -t myjenkins-blueocean:2.504.2 .
```

## Create the network 'jenkins'
```
docker network create jenkins
```

### Check for existing docker networks
```
docker network ls
```

## Run the Container on Windows
```
docker run --name jenkins-blueocean --restart=on-failure --detach `
  --network jenkins --env DOCKER_HOST=tcp://docker:2376 `
  --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 `
  --volume jenkins-data:/var/jenkins_home `
  --volume jenkins-docker-certs:/certs/client:ro `
  --publish 8080:8080 --publish 50000:50000 myjenkins-blueocean:2.504.2
```

## Shows currently running Docker containers
```
docker ps
```

## Get the Password
```
docker exec jenkins-blueocean cat /var/jenkins_home/secrets/initialAdminPassword
```