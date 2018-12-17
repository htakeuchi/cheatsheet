require 'erb'
require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'
require 'front_matter_parser'
require 'date'
require 'pp'

module CheatSheetGenerator
  COLUMNS = 3

  class MyRenderer < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet

    def table(header, body)
      "<table class='table is-striped'>" \
        "<tbody>#{body}</tbody>" \
      "</table>"
    end

    def header(text, header_level)
      "<h#{header_level} class='title is-#{header_level}'>#{text}</h#{header_level}>"
    end
  end

  def read_sections(f)
    loader = FrontMatterParser::Loader::Yaml.new(whitelist_classes: [Date])
    parsed = FrontMatterParser::Parser.parse_file(f, loader: loader)
    md = parsed.content
    [parsed.front_matter, md.scan(/^#+?\s.+?(?=^#)/m), md.lines.size]
  end

  def generate(front_matter, sections, lines)
    erb = ERB.new(File.read("./template/cheatsheet.erb"))    
    col_num = front_matter["column"].nil? ? COLUMNS : front_matter["column"]

    renderer = MyRenderer.new
    markdown = Redcarpet::Markdown.new(renderer, {
                                        tables: true,
                                        fenced_code_blocks: true
                                       })
    columns = []
    counter = 0
    sec = ""
    title = front_matter["title"]

    sections.each do |s|
      sec << s
      if (sec.lines.size > lines / col_num) && (counter < col_num - 1)
        columns << sec
        sec = ""
        counter += 1
      end
    end

    columns[-1] << sec
    erb.result(binding)
  end

  def self.convert(src, dest)
    front_matter, sections, lines = read_sections(src)
    File.open(dest.to_s, 'w') do |fw|
      fw.print generate(front_matter, sections, lines)
    end
  end

end