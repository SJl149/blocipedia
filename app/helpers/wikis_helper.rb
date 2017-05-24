module WikisHelper
  def markdown(text)
    extensions = {
      tables:                       true,
      fenced_code_blocks:           true,
      autolink:                     true,
      disable_indented_code_blocks: true,
      strikethrough:                true,
      superscript:                  true,
      underline:                    true,
      highlight:                    true,
      quote:                        true,
      footnotes:                    true
    }

    renderer = Redcarpet::Render::HTML
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end
end
