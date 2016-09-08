# -*- encoding : utf-8 -*-
module Haml::Filters::Markdown
  include Haml::Filters::Base

  markdown_extensions = {
    autolink: true,
    no_intraemphasis: true,
    superscript: true,
    fenced_code_blocks: true,
    tables: true
  }

  render_options = {
    filter_html: true
  }

  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(render_options),
                                     markdown_extensions)

  # using define_method rather than def to keep 'markdown' in scope
  define_method(:render) do |text|
    markdown.render(text)
  end
end
