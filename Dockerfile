FROM alpine:latest

ADD test.sh /opt/test.sh

RUN apk add --no-cache --virtual .build-deps ca-certificates curl \
 && chmod +x /opt/test.sh

ENTRYPOINT ["sh", "-c", "/opt/test.sh"]
