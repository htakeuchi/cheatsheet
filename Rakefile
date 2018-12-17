require_relative 'lib/cheatsheet_generator'
include CheatSheetGenerator

SRC = FileList['src/*.md']
DEST = SRC.pathmap('%{^src,public}X.html')

rule /public\/.*\.html/ => '%{^public,src}X.md' do |t|
  puts "generate #{t.source} --> #{t}"
  CheatSheetGenerator::convert(t.source, t)
end

desc 'Remove Cheetsheets'
task :clean do
  puts "rm #{DEST}"
  DEST.each do |f|   
    File.unlink(f) if File.exist? f
  end
end

desc 'Generate Cheetsheets from Markdown'
task :default => DEST