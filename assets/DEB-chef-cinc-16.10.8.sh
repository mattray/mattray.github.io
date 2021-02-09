#!/usr/bin/env bash

set -x # echo on

# Chef 16.10.8 DEB
date
sudo systemctl stop chef-client
sudo systemctl stop chef-client.timer
sudo apt remove omnibus-toolchain -y
sudo apt remove chef-workstation -y
sudo apt remove chef -y
sudo apt remove cinc -y

set -xuo pipefail #echo on, allow ruby failures

# Ruby 2.7.2
cd
rm -rf ~/.bundle
rm -rf ~/.gem
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
RUBYVERSION=$(ruby --version)
if [[ $RUBYVERSION =~ 2.7.2 ]]; then
  echo "Using existing Ruby 2.7.2 provided by rbenv"
else
  echo "Building Ruby 2.7.2"
  rm -rf ~/.rbenv
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  cd ~/.rbenv && src/configure && make -C src
  mkdir plugins
  git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
  rbenv install 2.7.2
  rbenv global 2.7.2
  eval "$(rbenv init -)"
fi

set -xeuo pipefail #echo on, stop on failures

# Omnibus-Toolchain
cd
rm -rf ~/omnibus-toolchain
sudo rm -rf /opt/omnibus-toolchain /var/cache/omnibus
sudo mkdir /opt/omnibus-toolchain
sudo mkdir /var/cache/omnibus
sudo chown omnibus:omnibus -R /opt/omnibus-toolchain
sudo chown omnibus:omnibus -R /var/cache/omnibus
git clone https://github.com/chef/omnibus-toolchain.git
cd omnibus-toolchain
bundle config set without 'development docs debug'
bundle install --path=.bundle
bundle exec omnibus build omnibus-toolchain -l internal
cp ~/omnibus-toolchain/pkg/omnibus-toolchain*deb ~/
sudo rm -rf /opt/omnibus-toolchain
sudo dpkg -i ~/omnibus-toolchain*deb
sudo chown omnibus:omnibus -R /opt/omnibus-toolchain
export PATH="/opt/omnibus-toolchain/bin:$PATH"

# Chef 16.10.8
cd
rm -rf ~/chef-16.10.8 ~/v16.10.8.tar.gz
sudo rm -rf /opt/chef
sudo mkdir /opt/chef
sudo chown omnibus:omnibus -R /opt/chef
wget https://github.com/chef/chef/archive/v16.10.8.tar.gz
tar -xzf v16.10.8.tar.gz
cd ~/chef-16.10.8/omnibus/
bundle config set without 'development docs debug'
bundle install --path=.bundle
bundle exec omnibus build chef -l internal
cp ~/chef-16.10.8/omnibus/pkg/chef*deb ~/
cp ~/chef-16.10.8/omnibus/pkg/chef*deb /tmp/

# Cinc 16.10.8
cd
rm -rf ~/cinc-full-16.10.8 ~/cinc-full-16.10.8.tar.xz
sudo rm -rf /opt/chef /opt/cinc
sudo mkdir /opt/cinc
sudo chown omnibus:omnibus -R /opt/cinc
curl http://downloads.cinc.sh/source/stable/cinc/cinc-full-16.10.8.tar.xz --output cinc-full-16.10.8.tar.xz
tar -xJf cinc-full-16.10.8.tar.xz
cd cinc-full-16.10.8/cinc-16.10.8/omnibus/
bundle lock --update=chef
bundle config set without 'development docs debug'
bundle install --path=.bundle
bundle exec omnibus build cinc -l internal
cp ~/cinc-full-16.10.8/cinc-16.10.8/omnibus/pkg/cinc*deb ~/
cp ~/cinc-full-16.10.8/cinc-16.10.8/omnibus/pkg/cinc*deb /tmp/

chmod 644 /tmp/*deb

echo "16.10.8 Complete!"
date
