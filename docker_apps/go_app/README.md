# Simple Go Application for AjoCard

This repo is a companion repo to deploy [Deploy a simple Go HTTP Application](https://github.com/ayobuba/AjoCardGo) in a Docker container. 

The container has been pushed to my personal [Docker public registry](https:hub.docker.com)

This app has already been built using "go build" and "go mod init github.com/callicoder/go-docker" for dependency management.

To run the app locally
```shell
$  ./go-docker   
```

Server can be accessed using curl
```shell
$curl --request GET -sL \
     --url 'http://localhost:8083'
Hello, Guest
```
```shell
$ curl http://localhost:8083?name=Shekarau
Hello, Shekarau
```

You can build the Docker image by running
```shell
$ docker build -t go-docker .
```

You can run the Docker image by running
```shell
$ docker run -d -p 8083:8083 go-docker
```

Image -  b6d10ab97686
go-docker:latest

resources
https://www.callicoder.com/docker-golang-image-container-example/
https://ropenscilabs.github.io/r-docker-tutorial/04-Dockerhub.html
