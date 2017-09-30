
bundle exec danger --fail-on-errors=true
cd '../../examples/ruby/cucumber_ios/'
brew install rbenv
rbenv install 2.3.1
rbenv rehash
rbenv global 2.3.1
rbenv local 2.3.1
rake
