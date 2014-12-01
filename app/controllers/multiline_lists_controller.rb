class MultilineListsController < ApplicationController
  def create
    @resume = Resume.find(params[:resume_id])
    if @resume != nil
      @resume.multiline_lists << MultilineList.new
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
end
