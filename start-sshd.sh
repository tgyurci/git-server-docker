#!/bin/sh

: "${SSHD_CONFIG_DIR:="/etc/ssh"}"
: "${SSHD_HOST_KEY_ALGOS:="rsa ecdsa ed25519"}"
: "${SSHD_HOST_KEY_COMMENT:=""}"

for algo in $SSHD_HOST_KEY_ALGOS; do
	host_key_file="${SSHD_CONFIG_DIR}/ssh_host_${algo}_key"

	[ -f "$host_key_file" ] || {
		echo "Generating host key: $host_key_file"
		ssh-keygen -q -f "$host_key_file" -t "$algo" ${SSHD_HOST_KEY_COMMENT:+-C "${SSHD_HOST_KEY_COMMENT}"} -N ''
		ssh-keygen -l -f "$host_key_file"
	}
done

/usr/sbin/sshd -D -e ${SSHD_OPTS}
