describe ResumesController, type: :controller do
  describe "Resume Rendering (GET #show)" do
    it "should assign template object" do
      resume = create(:resume)
      get :show, { id: resume.id }
      expect(assigns(:template)).to be_a Template
    end
  end
end
