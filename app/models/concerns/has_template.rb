module HasTemplate
  extend ActiveSupport::Concern 

  # return the partial name, with which this list is rendered
  # eg: 'mutiline_list', 'simple_list' ...
  def template
    return self.class.name.underscore
  end
end
