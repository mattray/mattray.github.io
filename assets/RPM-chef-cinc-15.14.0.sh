#!/bin/bash

set -x #echo on

# Chef 15.14.0 RPM
date
sudo systemctl stop chef-client
sudo systemctl stop chef-client.timer
sudo yum remove omnibus-toolchain -y
sudo yum remove chef-workstation -y
sudo yum remove chef -y
sudo yum remove cinc -y

set -xuo pipefail #echo on, allow ruby failures

# Ruby 2.7.1
cd
rm -rf ~/.bundle
rm -rf ~/.gem
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
RUBYVERSION=$(ruby --version)
if [[ $RUBYVERSION =~ 2.7.1 ]]; then
  echo "Using existing Ruby 2.7.1 provided by rbenv"
else
  echo "Building Ruby 2.7.1"
  rm -rf ~/.rbenv
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  cd ~/.rbenv && src/configure && make -C src
  mkdir plugins
  git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
  rbenv install 2.7.1
  rbenv global 2.7.1
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
cp ~/omnibus-toolchain/pkg/omnibus-toolchain*rpm ~/
sudo rm -rf /opt/omnibus-toolchain
sudo rpm -Uvh ~/omnibus-toolchain*rpm
sudo chown omnibus:omnibus -R /opt/omnibus-toolchain
export PATH="/opt/omnibus-toolchain/bin:$PATH"

# Chef 15.14.0
cd
rm -rf ~/chef-15.14.0 ~/v15.14.0.tar.gz
sudo rm -rf /opt/chef
sudo mkdir /opt/chef
sudo chown omnibus:omnibus -R /opt/chef
wget https://github.com/chef/chef/archive/v15.14.0.tar.gz
tar -xzf v15.14.0.tar.gz
cd ~/chef-15.14.0/omnibus/
bundle config set without 'development docs debug'
bundle install --path=.bundle
bundle exec omnibus build chef -l internal
cp ~/chef-15.14.0/omnibus/pkg/chef*rpm ~/
cp ~/chef-15.14.0/omnibus/pkg/chef*rpm /tmp/

# Cinc 15.14.0
cd
rm -rf ~/cinc-full-15.14.0.tar.xz
sudo rm -rf /opt/chef /opt/cinc
sudo mkdir /opt/cinc
sudo chown omnibus:omnibus -R /opt/cinc
curl http://downloads.cinc.sh/source/stable/cinc/cinc-full-15.14.0.tar.xz --output cinc-full-15.14.0.tar.xz
tar -xJf cinc-full-15.14.0.tar.xz
cd cinc-full-15.14.0/cinc-15.14.0/omnibus/
bundle config set without 'development docs debug'
bundle install --path=.bundle
bundle exec omnibus build cinc -l internal
cp ~/cinc-full-15.14.0/cinc-15.14.0/omnibus/pkg/cinc*rpm ~/
cp ~/cinc-full-15.14.0/cinc-15.14.0/omnibus/pkg/cinc*rpm /tmp/

chmod 644 /tmp/*rpm

echo "15.14.0 Complete!"
date
