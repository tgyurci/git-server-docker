#!/bin/sh

: "${SSHD_CONFIG_DIR:-"/etc/ssh"}"
: "${SSHD_HOST_KEY_ALGOS:-"rsa ecdsa ed25519"}"

for algo in $SSHD_HOST_KEY_ALGOS; do
	host_key_file="/etc/ssh/ssh_host_${algo}_key"

	[ -f "$host_key_file" ] || {
		echo "Generating host key: $host_key_file"
		ssh-keygen -q -f "$host_key_file" -t "$algo" -N ''
	}
done

/usr/sbin/sshd -D ${SSHD_DEBUG:+"-e"}
