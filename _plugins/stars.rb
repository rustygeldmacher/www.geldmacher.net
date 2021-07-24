module Jekyll
  module StarsFilter
    def stars(input)
      "<span class=\"stars\">#{star_map(input)}</span>"
    end

    private

    def star_map(count)
      (1..5).map do |i|
        if i <= count
          "&#9733;"
        else
          "&#9734;"
        end
      end.join
    end
  end
end

Liquid::Template.register_filter(Jekyll::StarsFilter)
