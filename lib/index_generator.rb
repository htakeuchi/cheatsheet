require 'erb'
require 'front_matter_parser'
require 'date'
require 'yaml'
require 'fileutils'
require 'pp'

module IndexGenerator
  def self.front_matter(f)
    loader = FrontMatterParser::Loader::Yaml.new(allowlist_classes: [Date])
    parsed = FrontMatterParser::Parser.parse_file(f, loader: loader)
    parsed.front_matter
  end

  def self.keywords(fm, name)
    values = fm[name].is_a?(Array) ? fm[name] : [fm[name]]
    values.compact.map(&:to_s).reject(&:empty?)
  end

  def self.add_entries(hash, name, f, fm)
    keywords(fm, name).each do |key|
      hash[key] << {:filename => f, :title => fm["title"] || File.basename(f, ".md")}
    end
  end

  def self.build_index(sources)
    category = Hash.new { |hash, key| hash[key] = [] }
    tags = Hash.new { |hash, key| hash[key] = [] }
    last_modify = []

    sources.map(&:to_s).sort.each do |f|
      next unless File.file?(f)

      fm = front_matter(f)
      add_entries(category, "category", f, fm)
      add_entries(tags, "tags", f, fm)
    end

    [category, tags, last_modify]
  end

  def self.create_index(category, tags, last_modify, dest = "./docs/index.html")
    erb = ERB.new(File.read("./template/index.erb"))
    @config = YAML.load_file('./config.yaml')
    FileUtils.mkdir_p(File.dirname(dest))
    File.open(dest, "w") {|f| f.print erb.result(binding)}
  end

  def self.generate_all(sources, dest = "./docs/index.html")
    category, tags, last_modify = build_index(sources)
    create_index(category, tags, last_modify, dest)
  end

  def self.generate(_f = nil)
    generate_all(Dir['src/*.md'])
  end
end
