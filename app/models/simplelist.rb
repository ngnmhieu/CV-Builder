class Simplelist < ActiveRecord::Base
  belongs_to :resume
  has_many :simplelistitems, dependent: :destroy

  # for mass update
  accepts_nested_attributes_for :simplelistitems, update_only: true

  after_initialize :default_values

  include HasOrderableItems
  include HasTemplate

  def default_values
    self.name ||= 'New Simple List'
  end

  # short hand for simplelist_items
  def items
    return  self.simplelistitems
  end

end
