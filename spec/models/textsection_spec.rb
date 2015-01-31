require 'rails_helper'

describe Textsection, type: :model do
  it "should have default name" do
      resume = create(:resume_with_items)
      list = resume.textsections.create

      expect(list.name).to eq 'New Text Section'
  end
end
