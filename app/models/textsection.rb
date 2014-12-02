class Textsection < ActiveRecord::Base
  belongs_to :resume
  include Orderable

  # return the partial name, with which this text section  is rendered with 
  def tpl_name
    return self.class.name.underscore
  end

  # return the data to be rendered
  def data
    return self
  end
end
