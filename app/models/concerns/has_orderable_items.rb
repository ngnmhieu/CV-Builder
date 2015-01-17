require 'active_support/concern'

module HasOrderableItems
  extend ActiveSupport::Concern 

  # Refresh the ordering of items after a deletion
  # @Requirement: 
  #   - #items method 
  #   - for each item: #order method 
  def refresh_ordering
    items.sort_by {|item| item.order.nil? ? 0 : item.order }.each_with_index do |item, i|
      item.order = i + 1
      item.save
    end
  end
end
