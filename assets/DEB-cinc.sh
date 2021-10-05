#!/usr/bin/env bash

if [ -z "$VERSION" ]; then echo "\$VERSION is unset"; exit; fi

set -xu # xtrace, nounset

# Cinc $VERSION DEB
date
sudo systemctl stop cinc-client
sudo systemctl stop cinc-client.timer
sudo apt remove omnibus-toolchain -y
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

# Cinc $VERSION
mkdir ~/$VERSION
cd ~/$VERSION
rm -rf ~/$VERSION/cinc-full-$VERSION ~/$VERSION/cinc-full-$VERSION.tar.xz
sudo rm -rf /opt/chef /opt/cinc
sudo mkdir /opt/cinc
sudo chown omnibus:omnibus -R /opt/cinc
curl http://downloads.cinc.sh/source/stable/cinc/cinc-full-$VERSION.tar.xz --output cinc-full-$VERSION.tar.xz
tar -xJf cinc-full-$VERSION.tar.xz
cd cinc-full-$VERSION/cinc-$VERSION/omnibus/
bundle lock --update=chef
bundle install --path=.bundle
bundle exec omnibus build cinc -l internal
cp ~/$VERSION/cinc-full-$VERSION/cinc-$VERSION/omnibus/pkg/cinc*deb ~/
cp ~/$VERSION/cinc-full-$VERSION/cinc-$VERSION/omnibus/pkg/cinc*deb /tmp/
sudo cp ~/$VERSION/cinc-full-$VERSION/cinc-$VERSION/omnibus/pkg/cinc*deb /root/

chmod 644 /tmp/*deb

echo "$VERSION Complete!"
date
