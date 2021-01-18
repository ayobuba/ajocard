FROM golang:latest
LABEL maintainer="Shekarau Edward Buba <shekarau.buba@outlook.com"
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o main
EXPOSE 8083
CMD ["./main"]