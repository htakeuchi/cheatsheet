require 'webrick'
require_relative 'lib/cheatsheet_generator'
require_relative 'lib/index_generator'
include CheatSheetGenerator
include IndexGenerator

SRC = FileList['src/*.md']
DEST = SRC.pathmap('%{^src,public}X.html')
CACHE = FileList['cache/*.yml']

rule /public\/.*\.html/ => '%{^public,src}X.md' do |t|
  puts "generate #{t.source} --> #{t}"
  CheatSheetGenerator::convert(t.source, t)
  IndexGenerator::generate(t.source)
end

desc 'Remove Cheetsheet HTMLs'
task :clean do
  puts "rm #{DEST}"
  DEST.each do |f|   
    File.unlink(f) if File.exist? f
  end
  puts "clean up cache"
  CACHE.each do |f|   
    File.unlink(f) if File.exist? f
  end
end

desc 'Generate Cheetsheets from Markdown'
task :default => DEST

desc 'Start Web Server'
task :server do
  WEBrick::HTTPServer.new(:DocumentRoot => "./public", :Port => 8000).start
end