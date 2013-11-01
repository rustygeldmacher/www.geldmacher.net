
desc "Show the tags that the posts have"
task :tags do
  system "grep 'tags:' _posts/* | awk '{ print $2 }' | sort | uniq -c"
end

desc "Package and deploy the site"
task :deploy do
  build_and_stage = ['bundle exec jekyll build', 'cd _site', 'tar pczf ../release.tar.gz .',
    'scp ../release.tar.gz www.geldmacher.net:'].join(' && ')
  system build_and_stage

  release_dir = "~/geldmacher.net/releases/#{Time.now.strftime('%Y%d%m%H%M%S')}"
  go_live = ["mkdir -p #{release_dir}", "tar xzf ~/release.tar.gz -C #{release_dir}",
    "rm geldmacher.net/current", "ln -s #{release_dir} ~/geldmacher.net/current",
    "rm ~/release.tar.gz"]
  system "ssh www.geldmacher.net '#{go_live.join(' && ')}'"
end
