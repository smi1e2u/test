FROM alpine:3.5
RUN apk add --no-cache --virtual .build-deps ca-certificates curl
ADD test.sh /test.sh
RUN chmod +x /test.sh
CMD /test.sh
