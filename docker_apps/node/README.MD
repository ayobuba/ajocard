# Simple Node.js Application for AjoCard

This repo is a companion repo to deploy [Deploy a simple Node.js HTTP Application](https://github.com/ayobuba/AjoCardGo) in a Docker container.

The image has been pushed to my personal [Docker public registry](https://hub.docker.com/repository/docker/ayobuba/ajocard-sample-app)



To build the docker image
```shell
$  docker-compose build
```

Run the container (in the background)
```shell
$ docker-compose up -d
```

Stop the container
```shell
$ docker-compose stop
```

Hiting the 3000 port endpoint will return a "helloworld"
```shell
$ curl --request GET -sL \
     --url 'http://localhost:5000'
   
```

