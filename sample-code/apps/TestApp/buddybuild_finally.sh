#!/usr/bin/env bash

cd '../../examples/ruby/cucumber_ios/'
gem install bundler
gem install danger
rbenv rehash
bundle exec danger --fail-on-errors=true
brew update
brew unlink openssl
brew uninstall --ignore-dependencies openssl
brew install openssl
brew install rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
rbenv install 2.3.1
rbenv rehash
rbenv global 2.3.1
rbenv local 2.3.1
npm install -g appium
npm install wd
echo password | sudo -S authorize_ios
nohup appium --native-instruments-lib -lt 999999 &
sleep 15 && rake; pkill -f appium

