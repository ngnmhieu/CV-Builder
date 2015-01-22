class ResumesController < ApplicationController

  def index
    if logged_in?
      @resumes = current_user.resumes
      respond_to do |format|
        format.html
        # format.json 
      end
    else
      respond_to do |format|
        format.html do 
          flash[:notice] = "You have to be a user, in order to save your resumes."
          redirect_to register_path 
          return
        end
      end
    end
  end

  def create
    @resume = Resume.new
    @resume.template = Template.default
    current_user.resumes << @resume
    @resume.personal_detail = PersonalDetail.create
    if @resume.save
      redirect_to edit_resume_path(@resume)
    end
  end

  def show
    @resume   = Resume.find(params[:id])
    template = @resume.template || Template.default

    # variables that are available in the templates
    @data     = {
      'resume'   => @resume,
      'template' => template.codename,
      'sections' => @resume.items,
      'personal_detail' => @resume.personal_detail
    }

    # Hash containing Liquid-template file content 
    @template_content = template_contents(template.codename)
    set_liquid_path(template.codename)

    respond_to do |format|
      format.pdf do 
        @data['format'] = :pdf
        render pdf: @resume.name, encoding: 'utf-8',
               page_size: 'A4', margin: {left: 0, right: 0, top: 0, bottom: 0},
               template: 'resumes/show.html.erb', layout: nil
      end

      format.html do
        @data['format'] = :html
        render layout: nil
      end
    end
  end

  def edit
    @resume = Resume.find(params[:id])
    @sections = @resume.items
    @templates = Template.all

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
  def template_contents(template_name)
    template_path = Rails.root.join(ENV["APP.TEMPLATE_DIR"], template_name)
    head_tpl_file = template_path.join('resume_head.liquid')
    body_tpl_file = template_path.join('resume_body.liquid')

    return { head: File.read(head_tpl_file), body: File.read(body_tpl_file) }
  end

  def resume_params
    params.require(:resume).permit(
      :name, :template_id,
      personal_detail_attributes: [:name, :phone, :fax, :address, :address1, :address2, :address3, :email, :website, :sex, :dob, :id],
      simplelists_attributes: [:name, :id, :order, :ordered_list, simpleitems_attributes: [:id, :content, :order]],
      worklists_attributes: [:name, :id, :order, workitems_attributes: [:id, :line1, :line2, :desc, :start, :end, :order]],
      textsections_attributes: [:name, :id, :content, :order]
    )
  end

end
