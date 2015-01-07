class Worklist < ActiveRecord::Base
  belongs_to :resume
  has_many :workitems, dependent: :destroy
  liquid_methods  :template, :name, :items
  
  # for mass update
  accepts_nested_attributes_for :workitems, update_only: true

  include HasOrderableItems
  include HasTemplate

  after_initialize :default_attributes

  def default_attributes
    self.name ||= 'New Occupation List'
    self.order ||= self.resume.items.size + 1
  end

  # shorthand for workitems
  def items
    return self.workitems.order(:order)
  end

end
