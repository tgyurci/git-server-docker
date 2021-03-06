FROM alpine:latest

RUN apk add --no-cache openssh git rsync rrsync

RUN adduser -D -h /git -s /usr/bin/git-shell git \
	&& echo 'git:*' | chpasswd -e \
	&& chmod 750 /git

COPY git-shell-commands /git/git-shell-commands/

RUN adduser -D -h /rsync rsync \
	&& echo 'rsync:*' | chpasswd -e \
	&& chmod 750 /rsync

COPY start-sshd.sh /

EXPOSE 22

CMD [ "/start-sshd.sh" ]
