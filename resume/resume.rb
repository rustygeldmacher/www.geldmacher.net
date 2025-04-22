require 'yaml'
require 'json'
require 'ostruct'
require 'erb'
require 'cgi'
require 'date'
require 'kramdown'

class Resume
  attr_reader :yaml, :resume, :template

  def initialize(template_file)
    @yaml = YAML.safe_load(File.read(relative_path("resume.yml")))
    @resume = JSON.parse(yaml.to_json, object_class: OpenStruct)
    @template = File.read(template_file)
  end

  def render
    ERB.new(template, 0, "-<>").result(binding)
  end

  private

  def resume_html
    markdown_template = File.read("resume/resume.md.erb")
    markdown = ERB.new(markdown_template, 0, "-<>").result(binding)
    Kramdown::Document.new(markdown).to_html
  end

  def relative_path(path)
    File.expand_path(File.join(File.dirname(__FILE__), path))
  end

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
end
