class Simplelist < ActiveRecord::Base
  belongs_to :resume
  has_many :simplelistitems, dependent: :destroy

  accepts_nested_attributes_for :simplelistitems, update_only: true

  include Orderable

  after_initialize :default_values

  def default_values
    self.name ||= 'New Simple List'
    # may cause bug
    # self.simplelistitems << Simplelistitem.new() if self.simplelistitems.empty?
  end

  # short hand for simplelist_items
  def items
    return  self.simplelistitems
  end
  
  # return the partial name, with which this list is rendered with 
  def tpl_name
    return self.class.name.underscore
  end

  # return the data to be rendered (items of this lists)
  # TODO: check if this method is used
  def data
    return self.items
  end

  def refresh_ordering
    items.sort_by {|item| item.order }.each_with_index do |item, i|
      item.order = i + 1
      item.save
    end
  end

end
