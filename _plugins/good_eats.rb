require 'yaml'

module Jekyll
  module GoodEats
    class Index
      def self.index
        @index ||= load_index
      end

      def self.episodes(season)
        index[season]
      end

      def self.load_index
        data_files = File.expand_path('../../_data/good_eats/*.yml', __FILE__)
        Dir[data_files].each_with_object({}) do |filename, hash|
          yaml = YAML.load(File.read(filename))
          yaml.each do |episode|
            season = episode['season']
            hash[season] ||= []
            hash[season] << episode
          end
        end
      end
    end

    class SeasonTable < Liquid::Tag
      attr_accessor :season

      def initialize(tag_name, text, tokens)
        super
        @season = text.to_i
      end

      def render(context)
        @context = context

        <<~HTML
          <table>
            <tr>
              <th>Date</th>
              <th>Recipe</th>
              <th>Crowd</th>
              <th>Ease</th>
            </tr>
            #{render_rows}
          </table>
        HTML
      end

      def render_rows
        recipes = GoodEats::Index.episodes(season).flat_map do |episode|
          episode['recipes'].map do |recipe|
            <<~HTML
              <tr>
                <td>#{render_cooked_date(recipe)}</td>
                <td>#{render_recipe_link(recipe)}</td>
                <td>#{render_stars(recipe['crowd'])}</td>
                <td>#{render_stars(recipe['ease'])}</td>
              </tr>
            HTML
          end
        end
        recipes.join("\n")
      end

      def render_cooked_date(recipe)
        cooked_on = recipe['cooked_on']
        return if cooked_on.nil?

        post_url = if (post_slug = recipe['post'])
          post_url_tag = Jekyll::Tags::PostUrl.send(:new, 'post_url', recipe['post'], nil)
          post_url_tag.render(@context)
        end

        cooked_on = cooked_on.strftime("%-m/%-d/%Y")
        "<a href=\"#{post_url}\">#{cooked_on}</a>"
      end

      def render_recipe_link(recipe)
        "<a href=\"#{recipe['url']}\">#{recipe['name']}</a>"
      end

      def render_stars(rating)
        return if rating.nil?

        stars = (1..5).map do |i|
          i <= rating ?  "&#9733;" : "&#9734;"
        end.join

        "<span class=\"stars\">#{stars}</span>"
      end
    end
  end
end

Liquid::Template.register_tag('good_eats_season_table', Jekyll::GoodEats::SeasonTable)
