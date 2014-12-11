class Textsection < ActiveRecord::Base
  belongs_to :resume
  after_initialize :default_values

  include HasTemplate

  def default_values
    self.name ||= 'New Text Section'
    self.content ||= ''
  end

  # return the partial name, with which this text section  is rendered with 
  def tpl_name
    return self.class.name.underscore
  end

end
