class MultilineListsController < ApplicationController
  include OrderingMethods

  def create
    @resume = Resume.find(params[:resume_id])
    if @resume != nil
      order = @resume.items.size + 1
      list = @resume.multiline_lists.create(order: order)

      if @resume.save
        respond_to do |format|
          format.html { redirect_to edit_resume_path(@resume) }
          format.json do
            render json: {
              'status' => 'success',
              'section_name' => list.name,
              'section_order' => list.order,
              'html'   => render_to_string(partial: 'resumes/multiline_list_form.html.erb', locals: {data: list})
            }
          end
        end

      end
    end
  end

  def destroy
    list = MultilineList.find(params[:id])
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
