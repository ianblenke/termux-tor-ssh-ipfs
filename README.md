# termux-tor-ssh

This is an attempt at making something to easily purpose an android phone to be ssh reachable over a tor v3 hidden service, with a minimum of setup preparation.

As a work-in-progress, this will change for a bit until I get it working the way I like it.

## Usage:

    pkg install curl && curl -sL https://raw.githubusercontent.com/ianblenke/termux-tor-ssh/master/run.sh | GITHUB_USERS=ianblenke sh -x

After a `exit` and a restart of TermUX, it should show you your hidden service onion address, which should look something like this:

    bhffkxuwbzw3b46l2dqm2dykagiktjdi274twmhnblx4rxdsjxqxzsad.onion

Copy and paste that on your Android device and paste it into hangouts/messenger/slack to yourself.

Then I locally fire up [torbrowser](https://www.torproject.org/projects/torbrowser.html.en) to get my local tor running, and I add this to my `~/.ssh/config` file:

    host myphone
      User u0_a211
      IdentityFile ~/.ssh/id_rsa-ianblenke@github.com
      ProxyCommand ncat --proxy 127.0.0.1:9050 --proxy-type socks5 bhffkxuwbzw3b46l2dqm2dykagiktjdi274twmhnblx4rxdsjxqxzsad.onion 22

After which I can now simply:

    ssh myphone

