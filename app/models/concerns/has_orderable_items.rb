require 'active_support/concern'

module HasOrderableItems
  extend ActiveSupport::Concern 

  # refresh the ordering of items after a deletion
  # require: `items` method and `order` method for each item
  def refresh_ordering
    items.sort_by {|item| item.order.nil? ? 0 : item.order }.each_with_index do |item, i|
      item.order = i + 1
      item.save
    end
  end

  # might not be used anymore
  # def incr_order
  #   resume = self.resume 

  #   if self.order != 1
  #     prev_item = resume.items.select {|i| i.order == self.order - 1 }[0]
  #     self.order -= 1  # increase order of current item
  #     prev_item.order += 1 # decrease order of previous item

  #     return self.save && prev_item.save
  #   end

  #   return true
  # end  

  # might not be used anymore
  # def decr_order
  #   resume = self.resume 

  #   if self.order != resume.items.size
  #     next_item = resume.items.select {|i| i.order == self.order + 1 }[0]
  #     self.order += 1  # decrease order of current item
  #     next_item.order -= 1 # increase order of previous item

  #     return self.save && next_item.save
  #   end

  #   return true
  # end  

end
