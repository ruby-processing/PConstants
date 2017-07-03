task default: [:compile, :test]

desc 'Compile'
task :compile do
  sh 'mvn package'
end

desc 'Run TestSketch'
task :test do
  sh 'jruby test/has_constants_test.rb'
end

desc 'clean'
task :clean do
  sh 'rm -r target'
  sh 'rm lib/pconstants.jar'
end
