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
    self.name ||= 'New Work List'
  end

  # shorthand for workitems
  def items
    return self.workitems.order(:order)
  end

  def self.find_and_save(id, params)
    list = self.find(id)
    list.name = params[:name]
    list.order = params[:order]
    list.save
  end

end
