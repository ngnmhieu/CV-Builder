module OrderingMethods

  def increase_order
    model = controller_name.classify.constantize
    item = model.find(params[:id])
    if item.incr_order
      redirect_to edit_resume_path(params[:resume_id])
    end
  end

  def decrease_order
    model = controller_name.classify.constantize
    item = model.find(params[:id])
    if item.decr_order
      redirect_to edit_resume_path(params[:resume_id])
    end
  end 

end
