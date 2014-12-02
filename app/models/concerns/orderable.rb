require 'active_support/concern'

module Orderable
  extend ActiveSupport::Concern 

  def incr_order
    resume = self.resume 

    if self.order != 1
      prev_item = resume.items.select {|i| i.order == self.order - 1 }[0]
      self.order -= 1  # increase order of current item
      prev_item.order += 1 # decrease order of previous item

      return self.save && prev_item.save
    end

    return true
  end  

  def decr_order
    resume = self.resume 

    if self.order != resume.items.size
      next_item = resume.items.select {|i| i.order == self.order + 1 }[0]
      self.order += 1  # decrease order of current item
      next_item.order -= 1 # increase order of previous item

      return self.save && next_item.save
    end

    return true
  end  

end
