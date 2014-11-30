class Resume < ActiveRecord::Base
  has_one :personal_detail
  has_many :educations
  has_many :works
  has_many :simplelists

  accepts_nested_attributes_for :personal_detail, update_only: true
  accepts_nested_attributes_for :educations
  accepts_nested_attributes_for :works
  accepts_nested_attributes_for :simplelists
end
