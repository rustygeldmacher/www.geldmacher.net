module Jekyll
  class ProgressBarTag < Liquid::Block
    attr_reader :progress, :total

    def initialize(tag_name, markup, tokens)
      @progress, @total = markup.split.map(&:to_i)
      super
    end

    def render(context)
      text = super
      percentage = (progress * 100.0 / total).round(2)

      width = "width:#{percentage}%"
      css_class = "progressbar-bar"

      if percentage == 0.0
        css_class += " empty"
        width = ""
      end

      <<~HTML
        <h3>#{text.strip}: #{progress} of #{total}</h3>

        <div class="progressbar-container">
          <div class="#{css_class}" style="#{width}"> </div>
        </div>
      HTML
    end
  end
end

Liquid::Template.register_tag('progress_bar', Jekyll::ProgressBarTag)
