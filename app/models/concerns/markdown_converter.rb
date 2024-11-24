require "rouge/plugins/redcarpet"

module MarkdownConverter
  extend ActiveSupport::Concern

  RENDER_OPTIONS = {
    with_toc_data: true,
    hard_wrap: true,
    link_attributes: {rel: :nofollow}
  }.freeze

  EXTENSIONS = {
    autolink: true,
    disable_indented_code_blocks: true,
    fenced_code_blocks: true,
    footnotes: true,
    lax_spacing: true,
    no_intra_emphasis: true,
    space_after_headers: true,
    strikethrough: true,
    superscript: true,
    tables: true,
    underline: true
  }.freeze

  private

  def renderer
    @renderer ||= HTMLWithCodeBlocks.new(RENDER_OPTIONS)
  end

  def converter
    @converter ||= Redcarpet::Markdown.new(renderer, EXTENSIONS)
  end

  class HTMLWithCodeBlocks < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet

    def rouge_formatter(lexer)
      ArticleFormatter.new(lang: lexer.tag)
    end
  end

  class ArticleFormatter < Rouge::Formatters::HTMLTable
    def initialize(lang:)
      @lang = lang
      @formatter = Rouge::Formatters::HTML.new
      super(@formatter, {})
    end

    def stream(tokens, &b)
      last_val = nil
      num_lines = tokens.reduce(0) { |count, (_, val)| count + (last_val = val).count("\n") }
      formatted = @inner.format(tokens)
      unless last_val&.end_with?("\n")
        num_lines += 1
        formatted << "\n"
      end

      # generate the gutter
      formatted_line_numbers = (@start_line..(@start_line + num_lines - 1)).map do |i|
        sprintf(@line_format, i)
      end.join("\n") << "\n"

      buffer = [%(<div class="syntax" data-lang="#{@lang}"><div class="hscroll"><table><tbody><tr>)]
      # the "gl" class applies the style for Generic.Lineno
      buffer << %(<td class="gutter gl">)
      buffer << %(<pre class="lineno">#{formatted_line_numbers}</pre>)
      buffer << %(</td>)
      buffer << %(<td class="code"><pre>)
      buffer << formatted
      buffer << %(</pre></td>)
      buffer << %(</tr></tbody></table></div></div>)

      yield buffer.join
    end
  end
end
