class MultilineListItemsController < ApplicationController
  def create
    @list = MultilineList.find(params[:multiline_list_id])
    if @list != nil
      @list.multiline_list_items << MultilineListItem.new
      if @list.save
        redirect_to edit_resume_path(params[:resume_id])
      end
    end
  end

  def destroy
    @item = MultilineListItem.find(params[:id])
    if @item.destroy
      redirect_to edit_resume_path(params[:resume_id])
    end
  end
end
