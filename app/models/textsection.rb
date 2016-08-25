class Textsection < ActiveRecord::Base
  belongs_to :resume
  after_initialize :default_attributes
  liquid_methods  :template, :name, :content

  include HasTemplate

  def default_attributes
    self.name ||= 'New Text Section'
    self.content ||= ''
  end

  def self.find_and_save(id, params)
    textsection = self.find(id)
    textsection.name = params[:name]
    textsection.order = params[:order]
    textsection.content = params[:content]
    textsection.save
  end

  def deep_dup
    self.dup
  end
end
