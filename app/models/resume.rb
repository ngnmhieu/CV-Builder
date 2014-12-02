class Resume < ActiveRecord::Base
  has_one :personal_detail
  has_many :educations
  has_many :works
  has_many :simplelists
  has_many :multiline_lists

  accepts_nested_attributes_for :personal_detail, update_only: true
  accepts_nested_attributes_for :educations
  accepts_nested_attributes_for :works
  accepts_nested_attributes_for :simplelists
  accepts_nested_attributes_for :multiline_lists


  def num_items
    return self.simplelists.size + self.multiline_lists.size
  end

  def items
    return self.simplelists + self.multiline_lists
  end

end
