require 'erb'
require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'
require 'pp'

module CheatSheetGenerator
  COLUMNS = 3
  MAX_LINES = 40

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
    m = f.read
    [m.scan(/^#+?\s.+?(?=^#)/m), m.lines.size]
  end

  def generate(sections, lines, col_num)
    erb = ERB.new(File.read("./template/cheatsheet.erb"))
    
    renderer = MyRenderer.new
    markdown = Redcarpet::Markdown.new(renderer, {
                                        tables: true,
                                        fenced_code_blocks: true
                                       })
    columns = []
    counter = 0
    sec = ""
    title = ""

    sections.each do |s|
      if title.size == 0 && s =~ /^#\s(.+)/
        title = $1
        next
      end

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
    File.open(src, 'r') do |f|
      sections, lines = read_sections(f)
      File.open(dest.to_s, 'w') do |fw|
        fw.print generate(sections, lines, COLUMNS)
      end
    end
  end

end