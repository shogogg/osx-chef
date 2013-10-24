#!/bin/bash

BASE_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE}")"; pwd)"
cd "$BASE_DIR"

if [ ! -d "/usr/local" ]; then
  echo "Creating directory: /var/chef"
  echo "-----------------------------"
  sudo mkdir /usr/local
  echo ""
fi  

if [ ! -d "/var/chef" ]; then
  echo "Creating directory: /var/chef"
  echo "-----------------------------"
  sudo mkdir /var/chef
  sudo chown $USER:staff /var/chef
  echo ""
fi

GEM="$(which gem)"
if [ -z "$GEM" ]; then
  echo "This script requires ruby and gem. Please install them."
  exit 1
fi

CHEF_SOLO="$(which chef-solo)"
if [ -z "$CHEF_SOLO" ]; then
  echo "Installing Chef"
  echo "--------------------"
  sudo $GEM install chef --no-rdoc --no-ri
  if [ $? -ne 0 ]; then
    echo "Failed to install Chef"
    exit 1
  fi
  echo ""
  CHEF_SOLO="$(which chef-solo)"
fi

BERKS="$(which berks)"
if [ -z "$BERKS" ]; then
  echo "Installing Berkshelf"
  echo "--------------------"
  sudo $GEM install berkshelf --no-rdoc --no-ri
  if [ $? -ne 0 ]; then
    echo "Failed to install Berkshelf"
    exit 1
  fi
  echo ""
  BERKS="$(which berks)"
fi

echo "Installing cookbooks"
echo "--------------------"
$BERKS install --path cookbooks
echo ""

echo "Running chef-solo"
echo "-----------------"
rm -rf /tmp/osx-chef
mkdir /tmp/osx-chef
cp -pR cookbooks /tmp/osx-chef/cookbooks
cp -pR site-cookbooks /tmp/osx-chef/site-cookbooks
$CHEF_SOLO --config config/solo.rb --json-attributes config/attributes.json
echo ""
