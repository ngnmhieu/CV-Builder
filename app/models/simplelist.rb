class Simplelist < ActiveRecord::Base
  belongs_to :resume
  has_many :simpleitems, dependent: :destroy
  liquid_methods  :template, :name, :items, :ordered_list

  # for mass update
  accepts_nested_attributes_for :simpleitems, update_only: true

  after_initialize :default_attributes

  include HasOrderableItems
  include HasTemplate

  def default_attributes
    self.name ||= 'New Simple List'
    self.order ||= self.resume.items.size + 1
  end

  # shorthand for simplelist_items
  def items
    return self.simpleitems.order(:order)
  end
end
