class WorksController < ApplicationController
  def create
    @resume = Resume.find(params[:resume_id])
    if @resume != nil
      @resume.works << Work.new
      if @resume.save
        redirect_to edit_resume_path(@resume)
      end
    end
  end

  def destroy
    @edu = Work.find(params[:id])
    if @edu.destroy
      redirect_to edit_resume_path(params[:resume_id])
    end
  end
end
