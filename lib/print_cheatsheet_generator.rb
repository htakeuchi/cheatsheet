require 'erb'
require 'redcarpet'
require 'coderay'
require 'front_matter_parser'
require 'date'
require 'fileutils'

module PrintCheatSheetGenerator
  DEFAULT_COLUMNS = 3
  DEFAULT_PDF_CONFIG = {
    'paper' => 'A4',
    'orientation' => 'landscape',
    'columns' => 'auto',
    'margin_mm' => 6,
    'min_font_size_pt' => 5.5,
    'max_font_size_pt' => 8.0
  }.freeze

  class PrintRenderer < Redcarpet::Render::HTML
    def block_code(code, language)
      lang = (language.nil? || language.empty? ? 'plaintext' : language).to_sym
      CodeRay.scan(code, lang).div
    end

    def table(_header, body)
      "<table><tbody>#{body}</tbody></table>"
    end

    def header(text, header_level)
      "<h#{header_level}>#{text}</h#{header_level}>"
    end
  end

  def self.read_sections(path)
    loader = FrontMatterParser::Loader::Yaml.new(allowlist_classes: [Date])
    parsed = FrontMatterParser::Parser.parse_file(path, loader: loader)

    sections = []
    section = ''
    parsed.content.split(/(^#+?\s.+?$)/).each do |line|
      if /^#+?\s/ =~ line
        sections << section if section.strip.size.positive?
        section = line
      else
        section << line
      end
    end
    sections << section if section.strip.size.positive?

    [parsed.front_matter, sections]
  end

  def self.generate(front_matter, sections)
    erb = ERB.new(File.read('./template/cheatsheet_print.erb'))
    markdown = Redcarpet::Markdown.new(PrintRenderer.new, {
                                         tables: true,
                                         quote: true,
                                         autolink: true,
                                         hard_wrap: true,
                                         fenced_code_blocks: true
                                       })

    title = front_matter['title'] || ''
    description = front_matter['description'] || ''
    default_columns = front_matter['columns'] || DEFAULT_COLUMNS
    pdf_config = DEFAULT_PDF_CONFIG.merge(front_matter['pdf'] || {})
    rendered_sections = sections.map { |section| markdown.render(section) }

    erb.result(binding)
  end

  def self.convert(src, dest)
    front_matter, sections = read_sections(src)
    FileUtils.mkdir_p(File.dirname(dest.to_s))
    File.write(dest.to_s, generate(front_matter, sections))
  end
end
