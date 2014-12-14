class MultilineListItem < ActiveRecord::Base
  belongs_to :multiline_list

  after_initialize :default_attributes

  def default_attributes
    self.line1 ||= ''
    self.line2 ||= ''
    self.desc  ||= ''
    self.start ||= DateTime.now 
    self.end   ||= DateTime.now 
    self.order ||= self.multiline_list.items.size + 1
  end
end
