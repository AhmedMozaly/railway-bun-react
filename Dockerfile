ARG BUN_VERSION='0.1.3'

FROM alpine:latest as builder

WORKDIR /tmp

RUN apk --update add curl unzip

ARG BUN_VERSION

RUN curl -LO https://github.com/Jarred-Sumner/bun/releases/download/bun-v${BUN_VERSION}/bun-linux-x64.zip

RUN unzip bun-linux-x64.zip

FROM gcr.io/distroless/base-debian11

COPY --from=builder /tmp/bun-linux-x64/bun .

ADD . .

CMD ["/bun", "dev"]

EXPOSE 5000