FROM node:12 as node-image
LABEL maintainer="Shekarau Edward Buba <shekarau.buba@outlook.com"
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install --only=production
COPY ["app.js", "package.json", "./"]
COPY test views ./
EXPOSE 5000
CMD [ "npm", "start" ]

#Go Container
FROM golang:latest as go-image
LABEL maintainer="Shekarau Edward Buba <shekarau.buba@outlook.com"
WORKDIR /app
COPY go.mod go.sum GoDockerReadMe.md app.go go-docker ./
RUN go mod download
COPY . .
RUN go build -o main
EXPOSE 8083
CMD ["./main"]