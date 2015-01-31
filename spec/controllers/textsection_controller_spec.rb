require 'rails_helper'

describe TextsectionsController, type: :controller do
  before(:each) { @resume = create(:resume_with_items) }

  it "should create a text section" do
    expect do
      post :create, { resume_id: @resume.id }
    end.to change {@resume.textsections.size}.by 1
  end
end
