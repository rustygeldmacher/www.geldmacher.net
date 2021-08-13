require 'yaml'
require_relative 'progress_bar'

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

    class Progress < Liquid::Tag
      def initialize(tag_name, text, tokens)
        super
        @season = text.to_i
      end

      def render(context)
        current_season = Jekyll::ProgressBarHelper.render_bar(
          'Current Season Recipes',
          stats[:current_season_cooked],
          stats[:current_season_recipes]
        )

        overall_recipes = Jekyll::ProgressBarHelper.render_bar(
          'Total Recipes',
          stats[:total_cooked],
          stats[:total_recipes]
        )

        overall_seasons = Jekyll::ProgressBarHelper.render_bar(
          'Seasons',
          stats[:seasons_cooked],
          stats[:total_seasons]
        )

        [current_season, overall_recipes, overall_seasons].join("\n")
      end

      def stats
        @stats ||= calculate_stats(@season)
      end

      def calculate_stats(current_season)
        stats_hash = {
          total_recipes: 0,
          total_cooked: 0,
          seasons_cooked: 0,
          total_seasons: GoodEats::Index.index.keys.max,
          current_season_recipes: 0,
          current_season_cooked: 0
        }

        GoodEats::Index.index.each do |season, episodes|
          season_total_recipes = 0
          season_cooked_recipes = 0

          episodes.each do |episode|
            episode['recipes'].each do |recipe|
              season_total_recipes += 1

              if recipe['cooked_on']
                season_cooked_recipes += 1
              end
            end
          end

          if season == current_season
            stats_hash[:current_season_recipes] = season_total_recipes
            stats_hash[:current_season_cooked] = season_cooked_recipes
          end

          stats_hash[:total_recipes] += season_total_recipes
          stats_hash[:total_cooked] += season_cooked_recipes

          if season_cooked_recipes == season_total_recipes
            stats_hash[:seasons_cooked] += 1
          end
        end

        stats_hash
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

Liquid::Template.register_tag('good_eats_progress', Jekyll::GoodEats::Progress)
Liquid::Template.register_tag('good_eats_season_table', Jekyll::GoodEats::SeasonTable)
