require "cgi"

# Liquid tag for embedding a YouTube video by its ID:
#
#   {% youtube VIDEO_ID %}
#   {% youtube VIDEO_ID An optional accessible title %}
#
# Emits a static, privacy-friendly (youtube-nocookie.com) iframe sized by the
# `.embed-container` rule in styles/custom.css. Unlike the old `{% oembed %}`
# tag, it makes no network request at build time.
module Jekyll
  class YouTubeTag < Liquid::Tag
    ALLOW = "accelerometer; autoplay; clipboard-write; encrypted-media; " \
            "gyroscope; picture-in-picture; web-share"

    def initialize(tag_name, markup, tokens)
      super
      @id, @title = markup.strip.split(/\s+/, 2)
    end

    def render(context)
      id = render_liquid(@id, context)
      title = CGI.escapeHTML(@title ? render_liquid(@title, context) : "YouTube video")

      %(<div class="embed-container video youtube">) +
        %(<iframe src="https://www.youtube-nocookie.com/embed/#{id}" ) +
        %(title="#{title}" loading="lazy" allow="#{ALLOW}" ) +
        %(allowfullscreen></iframe></div>)
    end

    private

    def render_liquid(text, context)
      Liquid::Template.parse(text).render(context).strip
    end
  end
end

Liquid::Template.register_tag("youtube", Jekyll::YouTubeTag)
