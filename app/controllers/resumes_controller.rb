class ResumesController < ApplicationController

  def index
    if logged_in?
      @resumes = current_user.resumes
    else
      respond_to do |format|
        format.html do 
          flash[:notice] = "You have to be a user, in order to save your resumes."
          redirect_to register_path 
        end
      end
    end
  end

  def create
    @resume = Resume.new
    current_user.resumes << @resume
    @resume.personal_detail = PersonalDetail.create
    if @resume.save
      redirect_to edit_resume_path(@resume)
    end
  end

  def show
    @resume   = Resume.find(params[:id])
    @data     = {
      'resume'   => @resume,
      'sections' => @resume.items,
      'personal_detail' => @resume.personal_detail
    }
    @template = template_content(@resume.template)
    set_liquid_path(@resume.template)

    respond_to do |format|
      format.pdf do 
        render pdf: @resume.name, encoding: 'utf-8',
               template: 'resumes/show.html.erb', layout: nil
      end

      format.html { render layout: nil }
    end
  end

  def edit
    @resume = Resume.find(params[:id])
    @sections = @resume.items
    render layout: 'editor'
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

  # set the path for the specific resume's template (needed by `include` Tag in the template)
  # @param String
  def set_liquid_path(template_name)
    template_path = Rails.root.join(ENV["APP.TEMPLATE_DIR"], template_name)
    Liquid::Template.file_system = Liquid::LocalFileSystem.new(template_path)
  end

  # return the content of liquid template file
  # @param String
  def template_content(template_name)
    template_path = Rails.root.join(ENV["APP.TEMPLATE_DIR"], template_name, 'resume.liquid')
    return File.read(template_path)
  end

  def resume_params
    params.require(:resume).permit(
      :name, 
      personal_detail_attributes: [:name, :phone, :fax, :address, :address1, :address2, :address3, :email, :website, :sex, :dob, :id],
      simplelists_attributes: [:name, :id, :order, :ordered_list, simplelistitems_attributes: [:id, :content, :order]],
      multiline_lists_attributes: [:name, :id, :order, multiline_list_items_attributes: [:id, :line1, :line2, :desc, :start, :end, :order]],
      textsections_attributes: [:name, :id, :content, :order]
    )
  end

end
