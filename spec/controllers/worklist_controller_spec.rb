require 'rails_helper'

describe WorklistsController, type: :controller do
  before(:each) { @resume = create(:resume_with_items) }

  it "should create a work list" do
    expect do
      post :create, { resume_id: @resume.id }
    end.to change {@resume.worklists.size}.by 1
  end
end
