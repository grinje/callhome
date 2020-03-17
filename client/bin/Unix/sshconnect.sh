#!/bin/sh

# Create key with
# ssh-keygen -t rsa -b 4096 -C "host:descriptive_text"

# Port that your callhome listens to
PORT=22

# Your callhome address
ADDRESS=remote.host.somewhere

# Your backup callhome address
BACKUP=remote.backup.host


##############################################


SSHFLAGS="\
    -q \
    -o ServerAliveInterval=60 \
    -o UserKnownHostsFile=/dev/null \
    -o StrictHostKeyChecking=no \
    -o ServerAliveCountMax=2 \
    -o ExitOnForwardFailure=True \
    "

SSHCMD="ssh -T $SSHFLAGS -p $PORT callhome@${ADDRESS}"
SSHBCK="ssh -T $SSHFLAGS -p $PORT callhome@${BACKUP}"

while true; do
    TUNNEL=`$SSHCMD`
    if test 0${TUNNEL} -gt 0; then
      $SSHCMD -N -R "*:${TUNNEL}:127.0.0.1:22"
    else
      TUNNEL=`$SSHBCK`
      if test 0${TUNNEL} -gt 0; then
        $SSHBCK -N -R "*:${TUNNEL}:127.0.0.1:22"
      fi
    fi
    sleep 60
done

