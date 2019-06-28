FROM golang:latest

RUN mkdir -p /app

WORKDIR /app

ADD . /app


RUN cp -r ./samples/adsclient/go/src/speedle $GOPATH/src
RUN go get -u k8s.io/api/authorization/v1beta1
RUN go get -u k8s.io/client-go/kubernetes
RUN go get -u k8s.io/client-go/tools/clientcmd
RUN go get github.com/oracle/speedle/cmd/...
RUN ls $GOPATH/bin && echo $GOPATH

#RUN cd ./samples/integration/kubernetes-integration && ls
RUN cd ./samples/integration/kubernetes-integration && \
go build -gcflags="-e" -o speedle webhook.go && \
env GOOS=darwin GOARCH=386 go build -gcflags="-e" -o speedle_mac webhook.go

