class MultilineList < ActiveRecord::Base
  belongs_to :resume
  has_many :multiline_list_items, dependent: :destroy
  
  # for mass update
  accepts_nested_attributes_for :multiline_list_items, update_only: true

  include HasOrderableItems
  include HasTemplate

  after_initialize :default_values

  def default_values
    self.name ||= 'New Occupation List'
  end

  # short hand for multiline_list_items
  def items
    return self.multiline_list_items
  end

end
