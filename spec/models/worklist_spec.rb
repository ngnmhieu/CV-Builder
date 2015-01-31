require 'rails_helper'

describe Worklist, type: :model do
  it "should have default name" do
      resume = create(:resume_with_items)
      list = resume.worklists.create

      expect(list.name).to eq 'New Work List'
  end
end
