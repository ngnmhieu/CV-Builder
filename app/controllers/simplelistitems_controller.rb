class SimplelistitemsController < ApplicationController
  def create
    @resume = Resume.find(params[:resume_id])
    list = Simplelist.find(params[:simplelist_id])
    if list != nil
      item = Simplelistitem.new
      list.simplelistitems << item
      if list.save
        respond_to do |format|
          format.html { redirect_to edit_resume_path(params[:resume_id]) }
          format.json do 
            render json: { 
              'status' => 'success',
              'html'   => render_to_string(partial: 'resumes/simplelist_item_form.html.erb', layout: false, locals: {list: list, item: item})
            } 
          end
        end
      end
    end
  end

  def destroy
    @item = Simplelistitem.find(params[:id])
    if @item.destroy
      redirect_to edit_resume_path(params[:resume_id])
    end
  end
end
