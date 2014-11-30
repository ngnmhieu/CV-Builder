class EducationsController < ApplicationController 
  def create
    @resume = Resume.find(params[:resume_id])
    if @resume != nil
      @resume.educations << Education.new
      if @resume.save
        redirect_to edit_resume_path(@resume)
      end
    end
  end

  def destroy
    @edu = Education.find(params[:id])
    if @edu.destroy
      redirect_to edit_resume_path(params[:resume_id])
    end
  end
end
