require 'erb'
require 'front_matter_parser'
require 'date'
require 'yaml'
require 'pp'

module IndexGenerator
  CATEGORY_CACHE = "cache/category.yml"
  TAG_CACHE = "cache/tag.yml"
  LAST_MODIFY_CACHE = "cache/last_modify.yml"

# カテゴリ: カテゴリをキーとして{:filename, :title}の配列
# {"Ruby" => [{:filename = "hoge, :title = "hoge"}, {:filename = "fuga, :title = "fuga"}]}
# タグ: タグをキーとして{:filename, :title}の配列
# 更新日: {:filename, :title, :last_modify}の配列
=begin
title: Scrapbox
category: Web service
tags: [Featured]
updated: 2018-12-18
columns: 3
description: Wiki
=end

  def front_matter(f)
    loader = FrontMatterParser::Loader::Yaml.new(whitelist_classes: [Date])
    parsed = FrontMatterParser::Parser.parse_file(f, loader: loader)
    parsed.front_matter
  end

  def set_cache(cache, name, f, fm)
    hash = (File.exist?(cache) ? YAML.load_file(cache) : {})
    hash.each do |key, value|
      value.delete_if {|c| c[:filename] == f}
      hash[key] = value
    end
    
    keywords = fm[name].class == Array ? fm[name] : [fm[name]]
    keywords.each do |key|
      hash[key] = [] if hash[key].nil?
      hash[key] << {:filename => f, :title => fm["title"]}
    end

    open(cache, "w") {|f| YAML.dump(hash, f)}
    hash
  end

  def set_category(f, fm)
    set_cache(CATEGORY_CACHE, "category", f, fm)
  end

  def set_tags(f, fm)
    set_cache(TAG_CACHE, "tags", f, fm)
  end

  def set_last_modify(f, fm)
  end

  def create_index(category, tags, last_modify)
    erb = ERB.new(File.read("./template/index.erb"))    
    File.open("./public/index.html", "w") {|f| f.print erb.result(binding)}
  end

  def self.generate(f)
    fm = front_matter(f)

    category = set_category(f, fm)
    tags = set_tags(f, fm)
    last_modify = set_last_modify(f, fm)

    create_index(category, tags, last_modify)
  end

end