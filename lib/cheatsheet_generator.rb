require 'erb'
require 'redcarpet'
require 'coderay'
require 'front_matter_parser'
require 'date'
require 'pp'

module CheatSheetGenerator
  COLUMNS = 3

  class MyRenderer < Redcarpet::Render::HTML
    def block_code(code, language)
      lang = (language.nil? ? "plaintext" : language).to_sym
      CodeRay.scan(code, lang).div
    end

    def table(header, body)
      "<table class='table is-striped'>" \
        "<tbody>#{body}</tbody>" \
      "</table>"
    end

    def header(text, header_level)
      "<h#{header_level} class='title is-#{header_level+1}'>#{text}</h#{header_level}>"
    end
  end

  def read_sections(f)
    loader = FrontMatterParser::Loader::Yaml.new(whitelist_classes: [Date])
    parsed = FrontMatterParser::Parser.parse_file(f, loader: loader)

    sections = []
    s = ''
    counter = 0

    parsed.content.split(/(^#+?\s.+?$)/).each do |line|
    counter += line.lines.size
      if /^#+?\s/ =~ line
        sections << s if s.size > 0
        s = line
      else
        s << line
      end      
    end
    sections << s

    [parsed.front_matter, sections, counter]
  end
  
  def generate(front_matter, sections, lines)
    erb = ERB.new(File.read("./template/cheatsheet.erb"))    
    col_num = front_matter["columns"].nil? ? COLUMNS : front_matter["columns"]
    renderer = MyRenderer.new
    markdown = Redcarpet::Markdown.new(renderer, {
                                        tables: true,
                                        quote: true,
                                        autolink: true,
                                        hard_wrap: true,
                                        fenced_code_blocks: true
                                       })
    columns = []
    counter, line_cnt= 0, 0
    sec = []
    title = front_matter["title"] || ''
    description = front_matter["description"] || ''

    sections.each do |s|    
      sec << s
      line_cnt += s.lines.size

      if (line_cnt > (lines/col_num) * 0.8) && (counter < col_num-1)
        columns << sec
        sec = []
        line_cnt = 0
        counter += 1
      end
    end

    columns << sec
    column_class = %w(is-full is-half is-one-third)[col_num - 1]

    erb.result(binding)
  end

  def self.convert(src, dest)
    front_matter, sections, lines = read_sections(src)
    front_matter["html"] = src.sub(/src\//, '').sub(/\.md$/, '.html')
    File.open(dest.to_s, 'w') do |fw|
      fw.print generate(front_matter, sections, lines)
    end
  end

end