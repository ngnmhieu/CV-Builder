class Textsection < ActiveRecord::Base
  belongs_to :resume
  after_initialize :default_attributes
  liquid_methods  :template, :name, :content

  include HasTemplate

  def default_attributes
    self.name ||= 'New Text Section'
    self.content ||= ''
  end
end
