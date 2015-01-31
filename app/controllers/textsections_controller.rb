class TextsectionsController < ApplicationController

  def create
    @resume = Resume.find(params[:resume_id])
    if @resume != nil
      textsec = @resume.add_item(Textsection.new)

      if @resume.save
        respond_to do |format|
          format.html { redirect_to edit_resume_path(@resume) }
          format.json do
            render json: {
              'status' => 'success',
              'section_name' => textsec.name,
              'section_order' => textsec.order,
              'html'   => render_to_string(
                partial: 'resumes/textsection_form.html.erb',
                locals: {data: textsec}
              )
            }
          end
        end
      end
    end
  end

  def destroy
    sec = Textsection.find(params[:id])
    resume = Resume.find(params[:resume_id])

    if sec.destroy
      resume.refresh_ordering
      respond_to do |format|
        format.html { redirect_to edit_resume_path(params[:resume_id]) }
        format.json { render json: {status: 'success', msg: 'Section deleted', section_order: sec.order} }
      end
    end
  end

end
