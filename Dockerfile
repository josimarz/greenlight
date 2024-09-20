FROM golang:alpine AS builder

WORKDIR /var/app

COPY . .

RUN go build -ldflags='-s' -o api ./cmd/api

FROM scratch

WORKDIR /var/app

COPY --from=builder /var/app/api .

EXPOSE 4000

ENTRYPOINT [ "./api", "-db-dsn=postgres://greenlight:pa55word@db/greenlight?sslmode=disable" ]