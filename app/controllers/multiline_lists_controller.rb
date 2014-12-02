class MultilineListsController < ApplicationController
  def create
    @resume = Resume.find(params[:resume_id])
    if @resume != nil
      order = @resume.num_items + 1
      @resume.multiline_lists << MultilineList.new(order: order)
      if @resume.save
        redirect_to edit_resume_path(@resume)
      end
    end
  end

  def destroy
    @list = MultilineList.find(params[:id])
    if @list.destroy
      redirect_to edit_resume_path(params[:resume_id])
    end
  end

  def increase_order
    item = MultilineList.find(params[:id])
    resume = Resume.find(params[:resume_id])

    if item.order != 1
      prev_item = resume.items.select {|i| i.order == item.order - 1 }[0]
      item.order -= 1  # increase order of current item
      prev_item.order += 1 # decrease order of previous item
      if item.save && prev_item.save
        redirect_to edit_resume_path(params[:resume_id])
      end
    else
      redirect_to edit_resume_path(params[:resume_id])
    end
  end

  def decrease_order
    item = MultilineList.find(params[:id])
    resume = Resume.find(params[:resume_id])

    if item.order != resume.items.size
      next_item = resume.items.select {|i| i.order == item.order + 1 }[0]
      item.order += 1  # increase order of current item
      next_item.order -= 1 # decrease order of previous item
      if item.save && next_item.save
        redirect_to edit_resume_path(params[:resume_id])
      end
    else
      redirect_to edit_resume_path(params[:resume_id])
    end
  end

end
