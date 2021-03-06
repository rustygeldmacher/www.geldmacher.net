#!/usr/bin/env ruby

require 'yaml'
require 'json'
require 'ostruct'
require 'erb'
require 'cgi'
require 'date'
require 'kramdown'

def h(string)
  CGI.escapeHTML(string)
end

def m(string)
  html = Kramdown::Document.new(string).to_html
  # kludge out the <p> tags
  html.strip[3..-1][0..-5]
end

def each_group(array, group_count)
  group_size = array.size / group_count
  if array.size % group_count > 0
    group_size +=1
  end
  array.each_slice(group_size).each_with_index do |group, i|
    yield group, i
  end
end

def role_range(role)
  if role.when
    return role.when
  end

  start_date = Date.parse("#{role.start}-01")
  range = [start_date.strftime("%B %Y")]
  if role.end
    end_date = Date.parse("#{role.end}-01")
    range << end_date.strftime("%B %Y")
  else
    range << "Present"
  end
  range.join(" to ")
end

yaml = YAML.safe_load(File.read('resume.yml'))
resume = JSON.parse(yaml.to_json, object_class: OpenStruct)
template = File.read('resume.html.erb')
puts ERB.new(template, 0, "-<>").result(binding)


