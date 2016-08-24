class PagesController < ApplicationController
  def index
    if logged_in?
        redirect_to controller: 'resumes', action: 'index'
    end
  end
end
