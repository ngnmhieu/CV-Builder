class TextsectionsController < ApplicationController
  include OrderingMethods

  def create
    @resume = Resume.find(params[:resume_id])
    if @resume != nil
      order = @resume.num_items + 1
      @resume.textsections << Textsection.new(order: order)
      if @resume.save
        redirect_to edit_resume_path(@resume)
      end
    end
  end

  def destroy
    @sec = Textsection.find(params[:id])
    if @sec.destroy
      redirect_to edit_resume_path(params[:resume_id])
    end
  end
end
