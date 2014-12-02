class Resume < ActiveRecord::Base
  has_one :personal_detail, dependent: :destroy
  has_many :educations, dependent: :destroy
  has_many :works, dependent: :destroy
  has_many :simplelists, dependent: :destroy
  has_many :multiline_lists, dependent: :destroy
  has_many :textsections

  accepts_nested_attributes_for :personal_detail, update_only: true
  accepts_nested_attributes_for :educations
  accepts_nested_attributes_for :works
  accepts_nested_attributes_for :simplelists
  accepts_nested_attributes_for :multiline_lists
  accepts_nested_attributes_for :textsections


  def num_items
    return self.simplelists.size + self.multiline_lists.size + self.textsections.size
  end

  def items
    return self.simplelists + self.multiline_lists + self.textsections
  end

end
