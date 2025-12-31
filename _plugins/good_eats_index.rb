require 'yaml'

module GoodEats
  class Index
    def self.index
      @index ||= load_index
    end

    def self.seasons
      index.keys.sort
    end

    def self.episodes(season)
      index[season]
    end

    def self.recipes
      @recipes ||= index.each_with_object({}) do |(_, episodes), hash|
        episodes.each do |episode|
          episode['recipes'].each do |recipe|
            recipe_name = recipe['name']
            hash[recipe_name] = recipe
          end
        end
      end
    end

    def self.recipe_url(recipe_name)
      recipe = GoodEats::Index.recipes[recipe_name]
      if recipe.nil?
        raise "Couldn't find recipe: #{recipe_name}"
      end
      recipe['url']
    end

    def self.load_index
      data_files = File.expand_path('../../_data/good_eats/*.yml', __FILE__)
      Dir[data_files].each_with_object({}) do |filename, hash|
        yaml = YAML.load(File.read(filename))
        yaml.each do |episode|
          season = episode['season']
          # Filter out bonus recipes
          episode['recipes'].reject! { |r| r['is_bonus'] }
          hash[season] ||= []
          hash[season] << episode
        end
      end
    end
  end
end
