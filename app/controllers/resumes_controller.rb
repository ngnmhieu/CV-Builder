class ResumesController < ApplicationController
  def index
    @resumes = Resume.all
  end

  def new
    @resume = Resume.new
  end

  def create
    @resume = Resume.new(resume_params)
    @resume.personal_detail = PersonalDetail.new
    if @resume.save
      redirect_to resumes_path
    end
  end

  def show
    @resume = Resume.find(params[:id])
    @pdetail = @resume.personal_detail
  end

  def edit
    @resume = Resume.find(params[:id])
  end

  def update
    @resume = Resume.find(params[:id])

    if @resume.update(resume_params)
      redirect_to edit_resume_path(@resume)
    end
  end

  def destroy
    @resume = Resume.find(params[:id])
    @resume.destroy
    redirect_to resumes_path
  end

  private
    def resume_params
      params.require(:resume).permit(:name, personal_detail_attributes: [:name, :phone, :fax, :address, :email, :website, :sex, :dob])
    end

    def personal_detail_params
      params.require(:personal_detail).permit()
    end
  
end
