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
  
  describe "items" do
    it "should return correctly ordererd items"
  end
end
