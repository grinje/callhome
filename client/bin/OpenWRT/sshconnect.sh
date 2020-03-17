#!/bin/sh

# Create key with
# dropbearkey -t rsa -s 4096 -f ~/.ssh/id_dropbear

# Port that your callhome listens to
PORT=22

# Your callhome address
ADDRESS=remote.host.somewhere

# Your backup callhome address
BACKUP=remote.backup.host

################################################

SSHFLAGS="\
    -K 60 \
    -y -y \
    -o ExitOnForwardFailure=yes \
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
