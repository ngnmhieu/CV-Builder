require 'rails_helper'

describe Resume, type: :model do
  describe "Default Attributes" do
    it "should have default name" do
      resume = create(:resume, name: nil)
      expect(resume.name).to eq "Unnamed Resume"
    end

    it "should have default template" do
      resume = create(:resume, template: nil)
      expect(resume.template).to eq Template.default
    end
  end
  
  context "Items" do
    before(:each) { @resume = create(:resume_with_items) }

    describe "#add_item" do
      it "should add item with correct order" do
        item = create(:simplelist)
        @resume.add_item(item)

        expect(item.order).to eq @resume.items.size + 1
      end

      it "should return saved item" do
        item = @resume.add_item(create(:simplelist))
        expect(item).to be_a Simplelist
      end

      it "should return nil if not a resume item" do
        expect(@resume.add_item(create(:user))).to be nil
      end
    end

    describe "#items" do
      it "should return correctly ordered items (#items)" do
        @resume = create(:resume_with_items)
        items = @resume.items
        (0...items.size-2).each do |i|
          expect(items[i].order).to be < items[i+1].order
        end
      end
    end

  end
end
