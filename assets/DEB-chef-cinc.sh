#!/usr/bin/env bash

if [ -z "$VERSION" ]; then echo "\$VERSION is unset"; exit; fi

set -xu # xtrace, nounset

# Chef $VERSION DEB
date
sudo systemctl stop chef-client
sudo systemctl stop chef-client.timer
sudo systemctl stop cinc-client
sudo systemctl stop cinc-client.timer
sudo apt remove omnibus-toolchain -y
sudo apt remove chef-workstation -y
sudo apt remove chef -y
sudo apt remove cinc -y

# Ruby 2.7.4
cd
rm -rf ~/.bundle
rm -rf ~/.gem
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
RUBYVERSION=$(ruby --version)
if [[ $RUBYVERSION =~ 2.7.4 ]]; then
  echo "Using existing Ruby 2.7.4 provided by rbenv"
else
  echo "Building Ruby 2.7.4"
  rm -rf ~/.rbenv
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  cd ~/.rbenv && src/configure && make -C src
  mkdir plugins
  git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
  rbenv install 2.7.4
  rbenv global 2.7.4
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

# Chef $VERSION
cd
rm -rf ~/chef-$VERSION ~/v$VERSION.tar.gz
sudo rm -rf /opt/chef
sudo mkdir /opt/chef
sudo chown omnibus:omnibus -R /opt/chef
wget https://github.com/chef/chef/archive/v$VERSION.tar.gz
tar -xzf v$VERSION.tar.gz
cd ~/chef-$VERSION/omnibus/
bundle config set without 'development docs debug'
bundle install --path=.bundle
bundle exec omnibus build chef -l internal
cp ~/chef-$VERSION/omnibus/pkg/chef*deb ~/
cp ~/chef-$VERSION/omnibus/pkg/chef*deb /tmp/
sudo cp ~/chef-$VERSION/omnibus/pkg/chef*deb /root/

# Cinc $VERSION
cd
rm -rf ~/cinc-full-$VERSION ~/cinc-full-$VERSION.tar.xz
sudo rm -rf /opt/chef /opt/cinc
sudo mkdir /opt/cinc
sudo chown omnibus:omnibus -R /opt/cinc
curl http://downloads.cinc.sh/source/stable/cinc/cinc-full-$VERSION.tar.xz --output cinc-full-$VERSION.tar.xz
tar -xJf cinc-full-$VERSION.tar.xz
cd cinc-full-$VERSION/cinc-$VERSION/omnibus/
bundle lock --update=chef
bundle config set without 'development docs debug'
bundle install --path=.bundle
bundle exec omnibus build cinc -l internal
cp ~/cinc-full-$VERSION/cinc-$VERSION/omnibus/pkg/cinc*deb ~/
cp ~/cinc-full-$VERSION/cinc-$VERSION/omnibus/pkg/cinc*deb /tmp/
sudo cp ~/cinc-full-$VERSION/cinc-$VERSION/omnibus/pkg/cinc*deb /root/

chmod 644 /tmp/*deb

echo "$VERSION Complete!"
date
