# Terraform + GCP SDK Docekr Image

This project builds a new Docker image with terraform and GCP tools installed. It is intended to be used to deploy apps using Terraform files.

## Docker build commands

```shell
docker build -t ariv3ra/terraform-gcp -t ariv3ra/terraform-gcp:alpine .
echo $DOCKER_PWD | docker login -u $DOCKER_LOGIN --password-stdin
docker push ariv3ra/terraform-gcp
```

## Docker run commands

```shell
docker run -it --rm=true ariv3ra/terraform-gcp /bin/sh
```
