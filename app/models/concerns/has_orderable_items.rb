require 'active_support/concern'

module HasOrderableItems
  extend ActiveSupport::Concern 

  # refresh the ordering of items after a deletion
  # require: `items` method and for each item an `order` method 
  def refresh_ordering
    items.sort_by {|item| item.order.nil? ? 0 : item.order }.each_with_index do |item, i|
      item.order = i + 1
      item.save
    end
  end

  def sorted_items
    return self.items.sort_by { |item| item.order }
  end
end
