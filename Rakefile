
desc "Show the tags that the posts have"
task :tags do
  system "grep 'tags:' _posts/* | awk '{ print $2 }' | sort | uniq -c"
end
