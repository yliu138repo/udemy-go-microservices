FROM golang:1.20-alpine as builder
RUN mkdir /app
COPY . /app
WORKDIR /app
RUN CGO_ENABLED=0 go build -o builtApp ./cmd/api
RUN chmod +x /app/builtApp

# BUild a tiny docker image
FROM alpine:latest

RUN mkdir /app

COPY --from=builder /app/builtApp /app

CMD [ "/app/builtApp" ]