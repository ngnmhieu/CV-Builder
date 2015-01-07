class MultilineList < ActiveRecord::Base
  belongs_to :resume
  has_many :multiline_list_items, dependent: :destroy
  liquid_methods  :template, :name, :items
  
  # for mass update
  accepts_nested_attributes_for :multiline_list_items, update_only: true

  include HasOrderableItems
  include HasTemplate

  after_initialize :default_attributes

  def default_attributes
    self.name ||= 'New Occupation List'
    self.order ||= self.resume.items.size + 1
  end

  # shorthand for multiline_list_items
  def items
    return self.multiline_list_items.order(:order)
  end

end
