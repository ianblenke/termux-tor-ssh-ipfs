#!/data/data/com.termux/files/usr/bin/sh -ex

# Optionally install SSH keys from a supplied list of GITHUB_USERS (or use arguments to this script to enumerate these)
GITHUB_USERS=${GITHUB_USERS:-$@}

# Install dependencies
which bash || pkg install bash
which git || pkg install git
which rsync || pkg install rsync
which sshd || pkg install openssh
which tor || pkg install tor

if [ -n "$GITHUB_USERS" ]; then

  # Add ssh keys from github user ianblenke
  touch ~/.ssh/authorized_keys
  (
    cat ~/.ssh/authorized_keys
    for user in $GITHUB_USERS; do
      curl -sL https://github.com/${user}.keys
    done
  ) | sort > ~/.ssh/authorized_keys.new
  mv ~/.ssh/authorized_keys.new ~/.ssh/authorized_keys
  chmod 700 ~/.ssh
  chmod 600 ~/.ssh/authorized_keys

fi

if [ ! -d ~/termux-tor-ssh ]; then
  git clone https://github.com/ianblenke/termux-tor-ssh ~/termux-tor-ssh
fi

cd ~/termux-tor-ssh
rsync -SHPaxq .bash_profile ~/.bash_profile
rsync -SHPaxq .sv/ ~/.sv
rsync -SHPaxq usr/ ~/../usr/

export SVDIR=~/.sv

sv up tor
sv up sshd

sleep 1

if [ -f ~/../usr/var/lib/tor/ssh/hostname ]; then
  cat ~/../usr/var/lib/tor/ssh/hostname
fi
