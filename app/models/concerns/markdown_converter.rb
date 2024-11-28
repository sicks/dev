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
      buffer = [%(<div class="syntax" data-lang="#{@lang}"><div class="hscroll"><pre><code>)]
      buffer << @inner.format(tokens)
      buffer << %(</code></pre></div></div>)

      yield buffer.join
    end
  end
end
