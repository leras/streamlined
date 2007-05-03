require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'test/ar_helper'

task :test => ['test:units', 'test:functionals']

desc 'Default: run tests.'
task :default => ['test']

namespace :test do
  desc 'Unit test the streamlined plugin.'
  Rake::TestTask.new('units') do |t|
    t.libs << 'test'
    t.pattern = 'test/unit/**/*_test.rb'
    t.verbose = true
  end

  desc 'Functional test the streamlined plugin.'
  Rake::TestTask.new('functionals') do |t|
    t.libs << 'test'
    t.pattern = 'test/functional/**/*_test.rb'
    t.verbose = true
  end
  
  task 'test:functionals'

  desc 'Build the MySQL test databases'
  task :build_mysql_databases do 
    %x( mysqladmin -u root create streamlined_unittest )
    # %x( mysql -u root -e "grant all on streamlined_unittest.* to root@localhost" )
    %x( mysql -u root streamlined_unittest < 'test/db/mysql.sql' )
  end
  
  desc 'Drop the MySQL test databases'
  task :drop_mysql_databases do 
    %x( mysqladmin -u root -f drop streamlined_unittest )
  end
  
  desc 'Rebuild the MySQL test databases'
  task :rebuild_mysql_databases => ['test:drop_mysql_databases', 'test:build_mysql_databases']
  
end

desc 'Generate documentation for the streamlined plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'RelevanceExtensions'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

require 'rcov/rcovtask'
namespace 'test' do
  namespace 'coverage' do
    namespace 'all' do
      task :test do
        rm_f "coverage"
        rm_f "coverage.data"
        rcov = "rcov --sort coverage --rails --aggregate coverage.data --text-summary -Ilib"
        system("#{rcov} --no-html test/unit/**/*_test.rb")
        system("#{rcov} --html test/functional/**/*_test.rb")  
      end
    end
    task :report => "all:test" do
      system("open coverage/index.html") if PLATFORM['darwin']
    end
  end
end

namespace :log do
  desc "Truncates all *.log files in log/ to zero bytes"
  task :clear do
    FileList["log/*.log"].each do |log_file|
      f = File.open(log_file, "w")
      f.close
    end
  end
end