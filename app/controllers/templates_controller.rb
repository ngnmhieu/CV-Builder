class TemplatesController < ApplicationController
  def index
    @templates = Template.all
  end

  def new
    @template = Template.new
  end

  def edit
    @template = Template.find(params[:id])

    if @template.nil?
      respond_to do |format|
        format.html { redirect_to templates_path }
      end
    end
  end

  def create
    @template = Template.new(template_params)

    if @template.save
      respond_to do |format|
        format.html { redirect_to templates_path }
      end
    else
      respond_to do |format|
        format.html { render :new }
      end
    end
  end

  def update
    @template = Template.find(params[:id])

    if @template.nil?
      respond_to do |format|
        format.html { redirect_to templates_path }
      end
    elsif @template.update_attributes(template_params)
      respond_to do |format|
        format.html { redirect_to templates_path }
      end
    else
      respond_to do |format|
        format.html { render :edit }
      end
    end
  end

  def destroy
    @template = Template.find(params[:id])
    if @template.nil?
      flash[:notice] = 'Sorry, no template found.'
      redirect_to templates_path 
    elsif @template.destroy
      respond_to do |format|
        format.html { redirect_to templates_path }
      end
    else
      respond_to do |format|
        format.html do 
          flash[:warning] = 'Sorry, template cannot be deleted, please try again later.'
          redirect_to templates_path 
        end
      end
    end
  end

  private
    def template_params
      params.require(:template).permit(:name, :codename)
    end
end
