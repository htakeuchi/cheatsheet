require 'webrick'
require 'fileutils'
require_relative 'lib/cheatsheet_generator'
require_relative 'lib/index_generator'
require_relative 'lib/print_cheatsheet_generator'
include CheatSheetGenerator
include IndexGenerator

SRC = FileList['src/*.md']
DEST = SRC.pathmap('%{^src,docs}X.html')
PRINT_DEST = SRC.pathmap('%{^src,docs/print}X.html')
PDF_DEST = SRC.pathmap('%{^src,docs/pdf}X.pdf')
CACHE = FileList['cache/*.yml']

rule %r{\Adocs/[^/]+\.html\z} => '%{^docs,src}X.md' do |t|
  puts "generate #{t.source} --> #{t}"
  CheatSheetGenerator::convert(t.source, t)
  IndexGenerator::generate(t.source)
end

rule %r{\Adocs/print/.*\.html\z} => '%{^docs/print,src}X.md' do |t|
  puts "generate print #{t.source} --> #{t.name}"
  PrintCheatSheetGenerator::convert(t.source, t.name)
end

rule %r{\Adocs/pdf/.*\.pdf\z} => '%{^docs/pdf,docs/print}X.html' do |t|
  puts "generate pdf #{t.source} --> #{t.name}"
  FileUtils.mkdir_p(File.dirname(t.name))
  sh(*pdf_export_args(t.source, t.name))
  refresh_html_for_pdf(t.name)
end

def pdf_export_args(input, output)
  args = ['node', 'tools/pdf_export.js', '--input', input, '--output', output]
  {
    'PAPER' => '--paper',
    'ORIENTATION' => '--orientation',
    'MARGIN_MM' => '--margin-mm',
    'COLUMNS' => '--columns',
    'MIN_FONT_SIZE_PT' => '--min-font-size-pt',
    'MAX_FONT_SIZE_PT' => '--max-font-size-pt'
  }.each do |env_key, option|
    args.push(option, ENV[env_key]) if ENV[env_key] && !ENV[env_key].empty?
  end
  args
end

def refresh_html_for_pdf(pdf_path)
  src = pdf_path.sub(%r{\Adocs/pdf/}, 'src/').sub(/\.pdf\z/, '.md')
  dest = pdf_path.sub(%r{\Adocs/pdf/}, 'docs/').sub(/\.pdf\z/, '.html')
  return unless File.exist?(src)

  puts "refresh html #{src} --> #{dest}"
  CheatSheetGenerator::convert(src, dest)
end

desc 'Remove Cheetsheet HTMLs'
task :clean do
  puts "rm #{DEST}"
  DEST.each do |f|   
    File.unlink(f) if File.exist? f
  end
  puts "rm #{PRINT_DEST}"
  PRINT_DEST.each do |f|
    File.unlink(f) if File.exist? f
  end
  puts "rm #{PDF_DEST}"
  PDF_DEST.each do |f|
    File.unlink(f) if File.exist? f
  end
  puts "clean up cache"
  CACHE.each do |f|   
    File.unlink(f) if File.exist? f
  end
end

desc 'Generate Cheetsheet HTMLs and PDFs from Markdown'
task :default => PDF_DEST

desc 'Generate print-ready HTMLs from Markdown'
task :print => PRINT_DEST

desc 'Generate one print-ready PDF. Usage: bundle exec rake pdf:one SRC=src/flstudio.md [OUT=docs/pdf/flstudio.pdf]'
namespace :pdf do
  task :one do
    src = ENV['SRC']
    abort 'SRC=src/name.md is required' if src.nil? || src.empty?

    print_dest = src.sub(%r{^src/}, 'docs/print/').sub(/\.md$/, '.html')
    pdf_dest = (ENV['OUT'] && !ENV['OUT'].empty?) ? ENV['OUT'] : src.sub(%r{^src/}, 'docs/pdf/').sub(/\.md$/, '.pdf')

    Rake::Task[print_dest].invoke
    FileUtils.mkdir_p(File.dirname(pdf_dest))
    sh(*pdf_export_args(print_dest, pdf_dest))
    refresh_html_for_pdf(pdf_dest)
  end
end

desc 'Generate print-ready PDFs from Markdown'
task :pdf => PDF_DEST

desc 'Start Web Server'
task :server do
  WEBrick::HTTPServer.new(:DocumentRoot => "./docs", :Port => 8000).start
end
