class Resume < ActiveRecord::Base
  has_one :personal_detail, dependent: :destroy
  has_many :educations, dependent: :destroy
  has_many :works, dependent: :destroy
  has_many :simplelists, dependent: :destroy
  has_many :multiline_lists, dependent: :destroy
  has_many :textsections

  # for mass update
  accepts_nested_attributes_for :personal_detail, update_only: true
  accepts_nested_attributes_for :simplelists, update_only: true
  accepts_nested_attributes_for :multiline_lists, update_only: true
  accepts_nested_attributes_for :textsections, update_only: true

  include HasOrderableItems

  def items
    return self.simplelists + self.multiline_lists + self.textsections
  end

end
