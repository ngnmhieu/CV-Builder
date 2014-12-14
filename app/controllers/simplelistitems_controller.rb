class SimplelistitemsController < ApplicationController

  def create
    @resume = Resume.find(params[:resume_id])
    list = Simplelist.find(params[:simplelist_id])

    if list != nil
      item = list.items.create

      if list.save
        respond_to do |format|
          format.html { redirect_to edit_resume_path(params[:resume_id]) }
          format.json do 
            render json: { 
              'status' => 'success',
              'html'   => render_to_string(
                partial: 'resumes/simplelist_item_form.html.erb', 
                layout: false, locals: {list: list, item: item}
              )
            } 
          end
        end
      end
    end

  end

  def destroy
    list = Simplelist.find(params[:simplelist_id])
    item = Simplelistitem.find(params[:id])

    if item.destroy
      list.refresh_ordering
      respond_to do |format|
        format.html { redirect_to edit_resume_path(params[:resume_id]) }
        format.json { render json: {status: 'success', msg: 'Item deleted'} }
      end
    end

  end

end
