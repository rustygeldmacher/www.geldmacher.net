#!/usr/bin/env ruby

require 'sinatra/base'
require 'sinatra/reloader'
require 'pathname'

# Load resume code
require_relative 'resume/resume'

class WwwGeldmacherNetServer < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  # Configure Sinatra
  set :public_folder, File.join(File.dirname(__FILE__), '_site')
  set :bind, '0.0.0.0'
  set :port, 4567

  # Routes

  get '/resume' do
    redirect '/resume/'
  end

  get '/resume/' do
    Resume.new("resume/resume.html.erb").render
  end

  get '/resume/resume.md' do
    Resume.new("resume/resume.md.erb").render
  end

  # Handle resume static files
  get %r{/resume/(css|js|images)/(.+)} do |type, file|
    file_path = File.join(File.dirname(__FILE__), 'resume', type, file)
    if File.exist?(file_path)
      send_file file_path
    else
      status 404
      "Not Found"
    end
  end

  # Fallback to static files in _site
  not_found do
    path = Pathname.new(request.path)
    static_path = File.join(settings.public_folder, path)

    if File.directory?(static_path)
      static_path = File.join(static_path, 'index.html')
    end

    if File.exist?(static_path)
      send_file static_path
    else
      status 404
      "Not Found"
    end
  end
end

# Start the server if this file is run directly
if __FILE__ == $0
  puts "Starting server at http://localhost:4567"
  WwwGeldmacherNetServer.run!
end
