FROM alpine:3:14

RUN apk --update add --no-cache postgresql-client

CMD ["psql"]