FROM alpine:latest

RUN apk add --no-cache openssh git rsync rrsync

RUN adduser -D -h /git -s /usr/bin/git-shell git \
	&& adduser -D -h /rsync rsync

COPY start-sshd.sh /

EXPOSE 22

CMD [ "/start-sshd.sh" ]
