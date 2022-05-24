FROM golang:1.18.2-alpine3.15

ENV GOOS linux
ENV GOARCH amd64
ENV PATH $PATH:/go/bin/linux_amd64
ENV GODEBUG asyncpreemptoff=1
ENV CRYPTOGRAPHY_DONT_BUILD_RUST 1
ENV CGO_ENABLED 0
RUN \
  echo http://dl-cdn.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories && \
  apk update --no-cache && \
  apk add --virtual .build \
  ca-certificates \
  bash \
  git \
  gcc \
  make \
  musl-dev \
  libffi-dev \
  curl \
  mysql-client \
  tzdata && \
  update-ca-certificates && \
  ln -f -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN wget -O- -nv https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s v1.41.1
RUN go install github.com/kyoh86/richgo@latest
RUN go install golang.org/x/tools/cmd/goimports@latest

WORKDIR /app

ADD go.mod .
ADD go.sum .
ADD Makefile .
RUN go mod download


ADD . /app
