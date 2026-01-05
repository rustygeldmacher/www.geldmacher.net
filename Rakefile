DEPLOY_TARGET="geldmacher@www.geldmacher.net"
CHROME_PATH="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

desc "Show the tags that the posts have"
task :tags do
  system "grep 'tags:' _posts/* | awk '{ print $2 }' | sort | uniq -c"
end

desc "Format Markdown"
task :format do
  Dir.chdir("good-eats") do
    Dir['*.md'].each do |markdown_file|
      next if ['updates.md'].include?(markdown_file)

      puts markdown_file
      format_cmd = "pandoc \"#{markdown_file}\" --standalone " \
        "-t gfm+yaml_metadata_block -o \"#{markdown_file}\""
      system(format_cmd)
    end
  end
end

desc "Build resume"
task :build_resume do
  unless File.exist?(CHROME_PATH)
    puts "Cannot find Google Chrome installed at #{CHROME_PATH}"
    exit 1
  end

  resume_files = `git ls-files resume/`.split
  newest_file = resume_files.map { |f| File.mtime(f) }.sort.last

  compiled_resume = 'resume/RustyGeldmacher.pdf'
  unless File.exist?(compiled_resume) && File.mtime(compiled_resume) > newest_file
    puts "Building resume..."

    require_relative 'server'

    Thread.new do
      WwwGeldmacherNetServer.run!
    end

    sleep 5

    FileUtils.rm_f('resume/index.html')
    FileUtils.rm_f('resume/RustyGeldmacher.pdf')
    system('curl --silent http://localhost:4567/resume/ > resume/index.html')
    # system('wkhtmltopdf --print-media-type http://localhost:4567/resume/ resume/RustyGeldmacher.pdf')
    system("'#{CHROME_PATH}' --headless --disable-gpu --no-pdf-header-footer --print-to-pdf=resume/RustyGeldmacher.pdf http://localhost:4567/resume/")
  end
end

desc "Build Good Eats Recipe Index"
task :build_recipe_index do
  require 'erb'
  require_relative "_plugins/good_eats_index"

  template_content = File.read("good-eats/_recipes.md.erb")
  erb_object = ERB.new(template_content, trim_mode: "-")
  output = erb_object.result(binding)

  File.open("good-eats/recipes.md", "w") do |f|
    f.write(output)
  end

  # File.open("good-eats/_list.md", "w") do |f|
  #   GoodEats::Index.seasons.each do |season|
  #     f.puts("## Season #{season}")
  #     f.puts
  #     GoodEats::Index.episodes(season).each do |episode|
  #       f.puts("### #{episode['title']}")
  #       f.puts
  #       episode['recipes'].each do |recipe|
  #         f.puts "- [#{recipe['name']}](#{recipe['url']})"
  #       end
  #       f.puts
  #     end
  #   end
  #   f.puts <<~SUMMARY
  #   ### Totals

  #   -   Seasons: 16
  #   -   Episodes: 264
  #   -   Recipes: 643
  #   SUMMARY
  # end
end

desc "Build the site"
task :build do
  build = [
    'rm -rf _site',
    'bundle exec jekyll build'
  ]
  system build.join(' && ')
end

desc "Upload the built site to the server"
task :stage => [:build_resume, :build] do
  stage = [
    'cd _site',
    'tar pczf ../release.tar.gz .',
    "scp ../release.tar.gz #{DEPLOY_TARGET}:"
  ]
  system stage.join(' && ')
end

desc "Package and deploy the site"
task :deploy => :stage do
  release_dir = "~/geldmacher.net/releases/#{Time.now.strftime('%Y%d%m%H%M%S')}"
  go_live = [
    "mkdir -p #{release_dir}",
    "tar xzf ~/release.tar.gz -C #{release_dir}",
    "chmod 644 #{release_dir}/.htaccess",
    "rm geldmacher.net/current",
    "ln -s #{release_dir} ~/geldmacher.net/current",
    "rm ~/release.tar.gz"
  ]
  system "ssh #{DEPLOY_TARGET} '#{go_live.join(' && ')}'"
end

desc "Start development environment with Jekyll and Resume server"
task :dev do
  puts "Starting development environment..."
  puts "Server will be available at http://localhost:4567/"
  system "foreman start"
end
