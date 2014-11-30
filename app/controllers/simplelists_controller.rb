class SimplelistsController < ApplicationController
  def create
    @resume = Resume.find(params[:resume_id])
    if @resume != nil
      @resume.simplelists << Simplelist.new
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
