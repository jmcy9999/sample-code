task :default => [:ios_full]

desc 'Build ios app'
task :build_ios do
  build_ios_app
end

desc 'run ios appium tests'
task :ios_full do
  run_ios_tests
 end



def run_ios_tests
  sh "bundle exec cucumber -p iphonesim"
end
