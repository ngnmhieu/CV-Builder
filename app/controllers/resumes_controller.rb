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
      params.require(:resume).permit(
        :name, 
        personal_detail_attributes: [:name, :phone, :fax, :address, :email, :website, :sex, :dob, :id],
        educations_attributes: [:institution, :degree, :desc, :start, :end, :id],
        works_attributes: [:company, :position, :desc, :start, :end, :id],
        simplelists_attributes: [:name, :id, simplelistitems_attributes: [:id, :content]],
        multiline_lists_attributes: [:name, :id, multiline_list_items_attributes: [:id, :line1, :line2, :desc, :start, :end]]
      )
    end
end
