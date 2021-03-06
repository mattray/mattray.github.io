#!/bin/bash

# Chef 15.6.10 DEB
echo `date`
sudo systemctl stop chef-client
sudo apt remove omnibus-toolchain -y
sudo apt remove chef -y

# Ruby 2.6.5
cd
rm -rf ~/.bundle
rm -rf ~/.gem
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
RUBYVERSION=$(ruby --version)
if [[ $RUBYVERSION =~ 2.6.5 ]]; then
  echo "Using existing Ruby 2.6.5 provided by rbenv"
else
  echo "Building Ruby 2.6.5"
  rm -rf ~/.rbenv
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  cd ~/.rbenv && src/configure && make -C src
  mkdir plugins
  git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
  rbenv install 2.6.5
  rbenv global 2.6.5
  eval "$(rbenv init -)"
fi

# # Omnibus-Toolchain
cd
rm -rf ~/omnibus-toolchain
sudo rm -rf /opt/omnibus-toolchain
sudo rm -rf /var/cache/omnibus/build /var/cache/omnibus/pkg /var/cache/omnibus/src
sudo mkdir /opt/omnibus-toolchain
sudo mkdir /var/cache/omnibus
sudo chown omnibus:omnibus -R /opt/omnibus-toolchain
sudo chown omnibus:omnibus -R /var/cache/omnibus
git clone https://github.com/chef/omnibus-toolchain.git
cd omnibus-toolchain
bundle install --without development --path=.bundle
bundle exec omnibus build omnibus-toolchain -l internal
cp ~/omnibus-toolchain/pkg/omnibus-toolchain*deb ~/
sudo rm -rf /opt/omnibus-toolchain
sudo dpkg -i ~/omnibus-toolchain/pkg/omnibus-toolchain*deb
export PATH="/opt/omnibus-toolchain/bin:$PATH"

# Chef 15.6.10
cd
rm -rf ~/chef-15.6.10 ~/v15.6.10.tar.gz
sudo rm -rf /opt/chef
sudo mkdir /opt/chef
sudo chown omnibus:omnibus -R /opt/chef
wget https://github.com/chef/chef/archive/v15.6.10.tar.gz
tar -xzf v15.6.10.tar.gz
cd ~/chef-15.6.10/omnibus/
bundle install --without development --path=.bundle
bundle exec omnibus build chef -l internal
cp ~/chef-15.6.10/omnibus/pkg/chef*deb ~/

echo "15.6.10 Complete!"
echo `date`
