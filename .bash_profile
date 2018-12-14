export SVDIR=$HOME/.sv

($HOME/bin/service-daemon start >/dev/null 2>&1 & )

sv up sshd
sv up tor
