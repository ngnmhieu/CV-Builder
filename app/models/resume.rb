class Resume < ActiveRecord::Base
  has_one :personal_detail
  has_many :educations

  accepts_nested_attributes_for :personal_detail
end
