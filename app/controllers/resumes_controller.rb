class ResumesController < ApplicationController
  def index
    @resumes = Resume.all
  end

  def new
    @resume = Resume.new
  end

  def create
    @resume = Resume.new(resume_params)
    @resume.personal_detail = PersonalDetail.create
    if @resume.save
      redirect_to resumes_path
    end
  end

  def show
    @resume = Resume.find(params[:id])
    @sections = @resume.items.sort_by {|item| item.order }
  end

  def edit
    @resume = Resume.find(params[:id])
    @sections = @resume.items.sort_by {|item| item.order }
  end

  def update
    @resume = Resume.find(params[:id])

    if @resume.update(resume_params)
      respond_to do |format|
        format.html { redirect_to edit_resume_path(@resume) }
        format.json { render json: {msg: 'Saved', status: 'success'} }
      end
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
        personal_detail_attributes: [:name, :phone, :fax, :address, :address1, :address2, :address3, :email, :website, :sex, :dob, :id],
        simplelists_attributes: [:name, :id, :order, simplelistitems_attributes: [:id, :content]],
        multiline_lists_attributes: [:name, :id, :order, multiline_list_items_attributes: [:id, :line1, :line2, :desc, :start, :end, :order]],
        textsections_attributes: [:name, :id, :content, :order]
      )
    end
end
