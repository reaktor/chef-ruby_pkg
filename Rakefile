require 'foodcritic'
require 'tailor/rake_task'

desc 'Run all tests'
task :default => [:foodcritic, :knife, :tailor]

FoodCritic::Rake::LintTask.new do |t|
  t.options = { :fail_tags => ['any'] }
end

desc 'Run Knife cookbook tests'
task :knife do
  dirname = File.basename(File.dirname(__FILE__))
  sh 'knife', 'cookbook', 'test', dirname, '--cookbook-path', '..'
end

Tailor::RakeTask.new do |t|
  t.file_set('metadata.rb', 'metadata')

  %w[attributes definitions libraries providers recipes resources].each do |dir|
    t.file_set("#{dir}/**/*.rb", dir) do |style|
      style.max_line_length 120, :level => :warn
    end
  end
end
