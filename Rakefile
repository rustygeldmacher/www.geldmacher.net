DEPLOY_TARGET="geldmacher@www.geldmacher.net"

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
  resume_files = `git ls-files resume/`.split
  newest_file = resume_files.map { |f| File.mtime(f) }.sort.last

  compiled_resume = 'resume/RustyGeldmacher.pdf'
  unless File.exist?(compiled_resume) && File.mtime(compiled_resume) > newest_file
    puts "Building resume..."
    resume = [
      'cd resume',
      'rm -f index.html',
      'rm -f RustyGeldmacher.pdf',
      'bundle exec ./resume.rb > index.html'
    ]
    system resume.join(' && ')

    require 'webrick'
    require 'logger'

    root = File.expand_path('resume')
    null_logger = Logger.new('/dev/null')

    Thread.new do
      server = WEBrick::HTTPServer.new(
        :Port => 2929,
        :DocumentRoot => root,
        :AccessLog => [null_logger, null_logger],
        :Logger => null_logger
      )

      server.start
    end

    sleep 5

    system('wkhtmltopdf http://localhost:2929/index.html?p=1 resume/RustyGeldmacher.pdf')
  end
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
    "rm geldmacher.net/current",
    "ln -s #{release_dir} ~/geldmacher.net/current",
    "rm ~/release.tar.gz"
  ]
  system "ssh #{DEPLOY_TARGET} '#{go_live.join(' && ')}'"
end
