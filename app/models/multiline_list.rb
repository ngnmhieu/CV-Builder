class MultilineList < ActiveRecord::Base
  belongs_to :resume
  has_many :multiline_list_items, dependent: :destroy
  accepts_nested_attributes_for :multiline_list_items, update_only: true

  # TODO: not used any more (because we have javascript)
  include Orderable

  after_initialize :default_values

  def default_values
    self.name ||= 'New Occupation List'
  end


  # short hand for multiline_list_items
  def items
    return self.multiline_list_items
  end

  # return the partial name, with which this list is rendered with 
  def tpl_name
    return self.class.name.underscore
  end

  # return the data to be rendered (items of this lists)
  # TODO: check if this is used
  def data
    return self.items
  end

  # require `items` method and order for its item
  def refresh_ordering
    items.sort_by {|item| item.order }.each_with_index do |item, i|
      item.order = i + 1
      item.save
    end
  end

end
