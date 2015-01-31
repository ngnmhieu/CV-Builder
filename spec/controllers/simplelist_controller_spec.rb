require 'rails_helper'

describe SimplelistsController, type: :controller do
  before(:each) { @resume = create(:resume_with_items) }

  it "should create a simple list" do
    expect do
      post :create, { resume_id: @resume.id }
    end.to change {@resume.simplelists.size}.by 1
  end
end
