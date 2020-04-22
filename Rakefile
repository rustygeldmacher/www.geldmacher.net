desc "Show the tags that the posts have"
task :tags do
  system "grep 'tags:' _posts/* | awk '{ print $2 }' | sort | uniq -c"
end

desc "Build resume"
task :build_resume do
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

  server_thread = Thread.new do
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

desc "Build the site"
task :build do
  build = [
    'rm -rf _site',
    'bundle exec jekyll build',
  ]
  system build.join(' && ')
end

desc "Upload the built site to the server"
task :stage => :build do
  stage = [
    'cd _site',
    'tar pczf ../release.tar.gz .',
    'scp ../release.tar.gz www.geldmacher.net:'
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
  system "ssh www.geldmacher.net '#{go_live.join(' && ')}'"
end
