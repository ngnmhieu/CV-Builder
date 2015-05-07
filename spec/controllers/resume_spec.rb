describe ResumesController, type: :controller do

  describe "Resume Listing (GET #index)" do
    context "User already logged in" do
      before(:each) { @user = create(:user_with_resumes) }

      it "should render index template when user logged in" do
        allow(@controller).to receive(:current_user) { @user }
        allow(@controller).to receive(:logged_in?) { true }

        get :index

        expect(response).to render_template('index')
      end

      it "should assign resume objects" do
        allow(@controller).to receive(:current_user) { @user }
        allow(@controller).to receive(:logged_in?) { true }

        get :index
        expect(assigns(:resumes)).to eq @user.resumes
      end
    end

    context "User not logged in" do
      it "should redirect to register page" do
        allow(@controller).to receive(:logged_in?) { false }
        get :index
        expect(response).to redirect_to(register_path)
      end
    end
  end

  describe "Resume Rendering (GET #show)" do
    it "should assign template object" do
      resume = create(:resume)
      get :show, { id: resume.id }
      expect(assigns(:template)).to be_a Template
    end
  end

  describe "Resume creation (POST #create)" do
    before(:each) do
      @current_user = create(:user)
    end

    it "should create new resume" do
      allow(@controller).to receive(:current_user) { @current_user }
      
      expect { post :create }.to change{ @current_user.resumes.count }.by 1
    end

    it "should redirect to editor page" do
      resume = create(:resume)
      allow(@controller).to receive(:current_user) { @current_user }
      allow(Resume).to receive(:new) { resume }
      allow_any_instance_of(Resume).to receive(:save) { true }

      post :create
      
      expect(response).to redirect_to(edit_resume_path(resume))
    end
  end

  describe "Resume Edit (GET #edit)" do
    it "should render editor layout" do
      resume = create(:resume)
      get :edit, { id: resume.id }

      expect(response).to render_template('edit')
    end

    it "should assign the resume" do
      resume = create(:resume)
      allow(Resume).to receive(:find) { resume }

      get :edit, { id: resume.id }

      expect(assigns(:resume)).to be(resume)
    end
  end

  describe "Resume Update (POST #update)" do
    before(:each) { @resume = create(:resume) }

    context "HTML Request" do
      it "should redirect to the editor if success" do
        allow_any_instance_of(Resume).to receive(:update_resume) { true }
        post :update, {id: @resume.id, resume: { name: @resume.name }  }

        expect(response).to redirect_to(edit_resume_path(@resume))
      end

      it "should update the resume" do
        allow_any_instance_of(Resume).to receive(:update_resume) { true }
        post :update, {id: @resume.id, resume: { name: @resume.name }  }

        expect(response).to redirect_to(edit_resume_path(@resume))
      end

      it "should implement sad path!"
    end

    context "JSON Request" do
      it "should return json message" do
        allow_any_instance_of(Resume).to receive(:update_resume) { true }

        post :update, { format: 'json', id: @resume.id, resume: { name: @resume.name }  }

        json_respond = JSON.parse(response.body)
        expect(json_respond).to eq({'msg' => 'Saved', 'status' => 'success'})
      end

      it "should implement sad path!"
    end
  end

  describe "Resume Delete (POST #destroy)" do
    it "should delete the resume" do
      resume = create(:resume)
      
      expect do 
        post :destroy, { id: resume.id } 
      end.to change { Resume.all.count }.by(-1)
    end
  end

end
