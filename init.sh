#!/usr/bin/env bash

SOFTWARE=""

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
SOFTWARE="$SOFTWARE google-chrome-stable"

wget -q -O - https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu yakkety stable" | sudo tee /etc/apt/sources.list.d/docker.list
SOFTWARE="$SOFTWARE docker-ce docker-compose"

sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
echo "deb http://linux.dropbox.com/ubuntu trusty main" | sudo tee /etc/apt/sources.list.d/dropbox.list
SOFTWARE="$SOFTWARE python-gpgme dropbox"

# PPA Repositories
sudo add-apt-repository -y ppa:webupd8team/atom
SOFTWARE="$SOFTWARE atom"

sudo add-apt-repository -y ppa:webupd8team/sublime-text-3
SOFTWARE="$SOFTWARE sublime-text-installer"

sudo add-apt-repository -y ppa:webupd8team/tor-browser
SOFTWARE="$SOFTWARE tor-browser"

# All other stuff from standard repos
SOFTWARE="$SOFTWARE byobu whois traceroute tcptraceroute iotop htop mosh gpa meld git zsh python-pip curl httpie xclip grc php7.0-cli php-codesniffer"

# Work dependences
SOFTWARE="$SOFTWARE cmake ccache libssl-dev libreadline-dev zlib1g-dev build-essential graphicsmagick-libmagick-dev-compat libmagickwand-dev libidn11-dev libldap2-dev libsasl2-dev libxml2-dev libxslt1-dev virtualbox docker graphviz libpq-dev"

# And now install 'em all
sudo apt-get -qq update
sudo apt-get install -y $SOFTWARE

sudo usermod -a -G docker `whoami`

# Install not apt-ed software
sudo -H pip -q --disable-pip-version-check install ansible==2.2.1.0 ansible-lint speedtest-cli

# Bash? Who need a bash in 21 century?!
[ $SHELL != `which zsh` ] && chsh -s `which zsh` $USER

# You now... For security
[ ! -s ~/.ssh/id_rsa ] && ssh-keygen -q -b 4096 -t rsa -f ~/.ssh/id_rsa
[ ! -s ~/.ssh/id_ecdsa ] && ssh-keygen -q -t ecdsa -f ~/.ssh/id_ecdsa

[ ! -d ~/bin ] && mkdir ~/bin

~/.dotfiles/install
~/.dotfiles/install

echo "Bootstraped"
exit 0
