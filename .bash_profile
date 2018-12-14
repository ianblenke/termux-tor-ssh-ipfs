export SVDIR=$HOME/.sv

($HOME/bin/service-daemon start >/dev/null 2>&1 & )

sleep 1

sv up sshd
sv up tor
sv up ipfs

if [ -f $HOME/../usr/var/lib/tor/ssh/hostname ]; then
  cat $HOME/../usr/var/lib/tor/ssh/hostname
fi
