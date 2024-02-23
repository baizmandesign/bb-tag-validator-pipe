FROM alpine:3.19

RUN apk update
RUN apk upgrade
RUN apk add bash git
#RUN apk add ca-certificates bash git
#RUN rm -rf /var/cache/apk/*

COPY pipe.sh /
RUN chmod +x /pipe.sh

# for testing
# https://stackoverflow.com/questions/61055324/docker-cannot-execute-binary-file
#ENTRYPOINT [ "/bin/bash", "-l", "-c" ]

ENTRYPOINT ["/pipe.sh"]