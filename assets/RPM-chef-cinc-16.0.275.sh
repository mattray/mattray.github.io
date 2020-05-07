#!/bin/bash
set -x #echo on

# Chef 16.0.275 RPM
echo `date`
sudo systemctl stop chef-client
sudo yum remove omnibus-toolchain -y
sudo yum remove chef -y
sudo yum remove cinc -y

set -xeuo pipefail #echo on, stop on failures

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

# # Omnibus-Toolchain
cd
rm -rf ~/omnibus-toolchain
sudo rm -rf /opt/omnibus-toolchain /var/cache/omnibus
sudo mkdir /opt/omnibus-toolchain
sudo mkdir /var/cache/omnibus
sudo chown omnibus:omnibus -R /opt/omnibus-toolchain
sudo chown omnibus:omnibus -R /var/cache/omnibus
git clone https://github.com/chef/omnibus-toolchain.git
cd omnibus-toolchain
sed -i "s/chef\/omnibus'/mattray\/omnibus', :branch => 'open_uri'/" Gemfile
bundle install --without development --path=.bundle
bundle exec omnibus build omnibus-toolchain -l internal
cp ~/omnibus-toolchain/pkg/omnibus-toolchain*rpm ~/
sudo rm -rf /opt/omnibus-toolchain
sudo rpm -Uvh ~/omnibus-toolchain*rpm
sudo chown omnibus:omnibus -R /opt/omnibus-toolchain
export PATH="/opt/omnibus-toolchain/bin:$PATH"

# Chef 16.0.275
cd
rm -rf ~/chef-16.0.275 ~/v16.0.275.tar.gz
sudo rm -rf /opt/chef
sudo mkdir /opt/chef
sudo chown omnibus:omnibus -R /opt/chef
wget https://github.com/chef/chef/archive/v16.0.275.tar.gz
tar -xzf v16.0.275.tar.gz
cd ~/chef-16.0.275/omnibus/
bundle install --without development --path=.bundle
bundle exec omnibus build chef -l internal
cp ~/chef-16.0.275/omnibus/pkg/chef*rpm ~/

# Cinc 16.0.275
cd
sudo rm -rf ~/cinc /opt/chef /opt/cinc ~/client-master.tar.gz
sudo mkdir /opt/cinc
sudo chown omnibus:omnibus -R /opt/cinc
wget https://gitlab.com/cinc-project/client/-/archive/master/client-master.tar.gz
tar -xzf client-master.tar.gz
mv client-master cinc
cd cinc
git config --global user.email "cinc@mattray.dev"
git config --global user.name "Matt Ray"
git clone -q -b v16.0.275 https://github.com/chef/chef.git
# patch patch.sh
sed -e '/^source/ s/^/# /' patch.sh > patch2.sh
sed -e '/^rm/,+3 s/^/# /' patch2.sh > patch3.sh
bash patch3.sh 16.0.275
cd chef/omnibus/
bundle install --without development --path=.bundle
bundle exec omnibus build cinc -l internal
cp ~/cinc/chef/omnibus/pkg/cinc*rpm ~/

echo "16.0.275 Complete!"
echo `date`
