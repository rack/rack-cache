require 'bundler/setup'
require 'bundler/gem_tasks'
require 'rake/clean'
require 'bump/tasks'

task :default => :test

CLEAN.include %w[coverage/ doc/api doc/gh-pages tags]
CLOBBER.include %w[dist]

desc 'Run tests'
task :test do
  sh "bundle exec mtest test"
end

desc 'Generate test coverage report'
task :rcov do
  sh "rcov -I.:lib:test test/*_test.rb"
end

# DOC =======================================================================
desc 'Build all documentation'
task :doc => %w[doc:api doc:markdown]

desc 'Build API documentation (doc/api)'
task 'doc:api' => 'doc/api/index.html'
file 'doc/api/index.html' => FileList['lib/**/*.rb'] do |f|
  rm_rf 'doc/api'
  sh((<<-SH).gsub(/[\s\n]+/, ' ').strip)
  rdoc
    --op doc/api
    --charset utf8
    --fmt hanna
    --line-numbers
    --main cache.rb
    --title 'Rack::Cache API Documentation'
    #{f.prerequisites.join(' ')}
  SH
end
CLEAN.include 'doc/api'

desc 'Build markdown documentation files'
task 'doc:markdown'
FileList['doc/*.markdown'].each do |source|
  dest = "doc/#{File.basename(source, '.markdown')}.html"
  file dest => [source, 'doc/layout.html.erb'] do |f|
    puts "markdown: #{source} -> #{dest}" if verbose
    require 'erb' unless defined? ERB
    template = File.read(source)
    content = Markdown.new(ERB.new(template, 0, "%<>").result(binding), :smart).to_html
    content.match("<h1>(.*)</h1>")[1] rescue ''
    layout = ERB.new(File.read("doc/layout.html.erb"), 0, "%<>")
    output = layout.result(binding)
    File.open(dest, 'w') { |io| io.write(output) }
  end
  task 'doc:markdown' => dest
  CLEAN.include dest
end

desc 'Move documentation to directory for github pages'
task 'doc:gh-pages' => [:clean, :doc] do
  html_files = FileList['doc/*.markdown'].map { |file| file.gsub('.markdown', '.html')}
  css_files = FileList['doc/*.css']

  FileUtils.mkdir('doc/gh-pages')
  FileUtils.cp_r('doc/api/', 'doc/gh-pages/api')
  FileUtils.cp([*html_files, *css_files], 'doc/gh-pages')
end

desc 'Start the documentation development server'
task 'doc:server' do
  sh 'cd doc && thin --rackup server.ru --port 3035 start'
end
