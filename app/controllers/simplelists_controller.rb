class SimplelistsController < ApplicationController

  def create
    @resume = Resume.find(params[:resume_id])
    if @resume != nil
      list = @resume.add_item(Simplelist.new)

      if @resume.save
        respond_to do |format|
          format.html { redirect_to edit_resume_path(@resume) }
          format.json do
            render json: {
              'status' => 'success',
              'section_name' => list.name,
              'section_order' => list.order,
              'html'   => render_to_string(
                partial: 'resumes/simplelist_form.html.erb',
                locals: { data: list }
              )
            }
          end
        end
        
      end
    end
  end

  def destroy
    list = Simplelist.find(params[:id])
    resume = Resume.find(params[:resume_id])

    if list.destroy
      resume.refresh_ordering
      respond_to do |format|
        format.html { redirect_to edit_resume_path(params[:resume_id]) }
        format.json { render json: {status: 'success', msg: 'Section deleted', section_order: list.order} }
      end
    end
  end

end
