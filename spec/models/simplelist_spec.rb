require 'rails_helper'

describe Simplelist, type: :model do
  it "should have default name" do
      resume = create(:resume_with_items)
      list = resume.simplelists.create

      expect(list.name).to eq 'New Simple List'
  end
end
