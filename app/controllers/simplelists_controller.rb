class SimplelistsController < ApplicationController
  include OrderingMethods

  def create
    @resume = Resume.find(params[:resume_id])
    if @resume != nil
      order = @resume.num_items + 1
      @resume.simplelists << Simplelist.new(order: order)
      if @resume.save
        redirect_to edit_resume_path(@resume)
      end
    end
  end

  def destroy
    @list = Simplelist.find(params[:id])
    if @list.destroy
      redirect_to edit_resume_path(params[:resume_id])
    end
  end
end
