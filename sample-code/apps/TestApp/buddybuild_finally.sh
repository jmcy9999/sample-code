#!/usr/bin/env bash

cd '../../examples/ruby/cucumber_ios/'
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
gem install bundler
gem install danger
bundle exec danger --fail-on-errors=true
rbenv rehash
npm install -g appium
npm install wd
nohup appium &
sleep 15 &&
brew unlink xz
bundle install
brew link xz
bundle exec cucumber -p iphonesim

