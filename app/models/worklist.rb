class Worklist < ActiveRecord::Base
  belongs_to :resume
  has_many :worklist_items, dependent: :destroy
  liquid_methods  :template, :name, :items
  
  # for mass update
  accepts_nested_attributes_for :worklist_items, update_only: true

  include HasOrderableItems
  include HasTemplate

  after_initialize :default_attributes

  def default_attributes
    self.name ||= 'New Occupation List'
    self.order ||= self.resume.items.size + 1
  end

  # shorthand for worklist_items
  def items
    return self.worklist_items.order(:order)
  end

end
