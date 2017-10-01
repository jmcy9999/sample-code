require 'socket'
require 'open3'

task :default => [:ios_full]


task :boot_appium => [
  'boot_appium:run'
] do |t|
  exit 1 if @errors
end

desc 'run ios appium tests'
task :ios_full do
  run_ios_tests
 end



def run_ios_tests
  sh "brew unlink xz"
  sh "bundle install"
  sh "brew link xz"
  sh "npm install -g appium"
  sh 'npm install wd'
  sh "appium &"
  sleep 30
  sh "bundle exec cucumber -p iphonesim"
end

namespace :boot_appium do
  desc "boot appium"
  task :run do
    host = '127.0.0.1'
    port = 4723

    pid = Boot.execute_appium(host, port)
    File.open('server.pid', 'w') { |f| f.write pid }
    task :ios_full do
      run_ios_tests
    end

    while true
      sleep 0.1
      Signal.trap('INT') do
        puts "About to kill process #{pid}"
        `kill -9 #{pid}`
        exit
      end
    end
  end
end

# Boots up the mock server by spawning a new thread,
# calling rack up and outputing stdout and stderr
class Boot

  def self.execute_appium(host, port)

    puts "About to boot appium server http://#{host}:#{port}"
    puts "CTRL + C to exit"

    command = "appium -a #{host} -p #{port}"

    stdin, stdout, stderr, wait_thr = Open3.popen3(command)
    [stdout, stderr].each do |stream|

      Thread.new do
        until (line = stream.gets).nil? do
          puts line
        end
      end
    end

    wait_thr[:pid]
    puts 'appium has been boooted'
  end
end

