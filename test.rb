require 'erb'
require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'
require 'front_matter_parser'
require 'date'
require 'pp'

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


# p File.open("src/vim.md").read.scan(/^#+?\s.+?(?=^#)/m)

parsed = FrontMatterParser::Parser.parse_file("src/vim.md")

pp parsed.front_matter

renderer = MyRenderer.new
markdown = Redcarpet::Markdown.new(renderer, {
                                    tables: true,
                                    fenced_code_blocks: true
                                   })


print markdown.render parsed.content
