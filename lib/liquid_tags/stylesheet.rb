require 'uri'
require 'cgi'

class LiquidTags::Stylesheet < Liquid::Tag

  def initialize(tag_name, params, tokens)
    # strip whitespace and surrounding quotes
    @filepath = params.strip.gsub(/^['"](.*)['"]$/, '\1')

    super
  end

  def render(context)
    if @filepath =~ URI::regexp
      stylesheet_path = @filepath
    else
      variables = context.environments.first
      template = variables['template']
      stylesheet_path = "/assets/resumes/#{template}/#{ CGI.escapeHTML(@filepath) }"
    end

    "<link rel='stylesheet' type='text/css' href='#{stylesheet_path}' media='all' />"
  end
end

