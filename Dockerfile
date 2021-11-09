FROM alpine:latest

RUN apk add --no-cache openssh git rsync rrsync

RUN adduser -D -h /git -s /usr/bin/git-shell git \
	&& echo 'git:*' | chpasswd -e \
	&& adduser -D -h /rsync rsync \
	&& echo 'rsync:*' | chpasswd -e

COPY git-shell-commands /git/
COPY start-sshd.sh /

EXPOSE 22

CMD [ "/start-sshd.sh" ]
