#!/bin/bash

BASE_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE}")"; pwd)"
cd "$BASE_DIR"

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

for DIR in "/usr/local" "/opt/local" "/var/chef"; do
  if [ ! -d "$DIR" ]; then
    echo "Creating directory: $DIR"
    echo "-----------------------------"
    sudo mkdir -p "$DIR"
    sudo chown $USER:staff "$DIR"
    echo ""
  fi
done

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
