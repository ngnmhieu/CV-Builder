class MultilineListItemsController < ApplicationController
  def create
    @resume = Resume.find(params[:resume_id])
    list = MultilineList.find(params[:multiline_list_id])
    if list != nil
      order = list.items.size + 1
      item = MultilineListItem.new(order: order)
      list.multiline_list_items << item

      if list.save
        respond_to do |format|
          format.html { redirect_to edit_resume_path(params[:resume_id]) }
          format.json do 
            render json: { 
              'status' => 'success',
              'html'   => render_to_string(partial: 'resumes/multiline_list_item_form.html.erb', layout: false, locals: {list: list, item: item})
            } 
          end
        end
      end
    end
  end

  def destroy
    @item = MultilineListItem.find(params[:id])
    if @item.destroy
      redirect_to edit_resume_path(params[:resume_id])
    end
  end

  def decrease_order
    @item = MultilineListItem.find(params[:id])
    list = MultilineList.find(params[:multiline_list_id])
    @next_item = MultilineListItem.find_by(
      multiline_list_id: params[:multiline_list_id],
      order: @item.order+1)

    if @item.order != list.multiline_list_items.size
      @item.order += 1;
      @next_item.order -= 1;
      if @item.save && @next_item.save
        redirect_to edit_resume_path(params[:resume_id])
      end
    else
        redirect_to edit_resume_path(params[:resume_id])
    end
  end

  def increase_order
    item = MultilineListItem.find(params[:id])
    list = MultilineList.find(params[:multiline_list_id])

    if item.order != 1
      prev_item = MultilineListItem.find_by(
        multiline_list_id: params[:multiline_list_id],
        order: item.order-1
      )

      item.order -= 1
      prev_item.order += 1

      if item.save && prev_item.save
        redirect_to edit_resume_path(params[:resume_id])
      end
    else
      redirect_to edit_resume_path(params[:resume_id])
    end
  end

  
  # maybe generalize increase_order and decrease_order
  def change_order(direction)
  end

end
