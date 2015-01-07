class Simpleitem < ActiveRecord::Base
  belongs_to :simplelist
  after_initialize :default_attributes
  liquid_methods :content

  def default_attributes
    self.content ||= ''
    self.order ||= self.simplelist.items.size + 1
  end

end
