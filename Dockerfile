# Stage 1: Build (builder)
FROM golang:1.24-alpine AS builder
WORKDIR /app
COPY src/* ./
RUN go mod download
RUN go build

# Stage 2: Runtime
FROM alpine:latest AS workspace
WORKDIR /app
COPY --from=builder /app/tidlarr-proxy /app/tidlarr-proxy
RUN mkdir -p /data/tidlarr
ENTRYPOINT ["./tidlarr-proxy"]
