class SimplelistitemsController < ApplicationController
  def create
    @list = Simplelist.find(params[:simplelist_id])
    if @list != nil
      @list.simplelistitems << Simplelistitem.new
      if @list.save
        redirect_to edit_resume_path(params[:resume_id])
      end
    end
  end

  def destroy
    @item = Simplelistitem.find(params[:id])
    if @item.destroy
      redirect_to edit_resume_path(params[:resume_id])
    end
  end
end
