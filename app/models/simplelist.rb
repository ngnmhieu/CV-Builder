class Simplelist < ActiveRecord::Base
  belongs_to :resume
  has_many :simplelistitems, dependent: :destroy

  accepts_nested_attributes_for :simplelistitems, update_only: true
end
