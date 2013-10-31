require 'spec_helper'

describe PapersController do

  ALLOWED_PARAMS = %i(short_title title abstract body)

  let :user do
    User.create! first_name: 'Albert',
      last_name: 'Einstein',
      email: 'einstein@example.org',
      password: 'password',
      password_confirmation: 'password',
      affiliation: 'Universität Zürich'
  end

  before { sign_in user }

  describe "GET 'new'" do
    subject(:do_request) { get :new }

    it_behaves_like "when the user is not signed in"

    it { should be_success }
    it { should render_template :new }
  end

  describe "POST 'create'" do
    subject(:do_request) do
      post :create, { paper: { short_title: 'ABC101' } }
    end

    it_behaves_like "when the user is not signed in"

    it_behaves_like "a controller enforcing strong parameters" do
      let(:model_identifier) { :paper }
      let(:allowed_params) { ALLOWED_PARAMS }
    end

    it "saves a new paper record" do
      do_request
      expect(Paper.first).to be_persisted
    end

    it "assigns the paper to the current user" do
      do_request
      expect(Paper.first.user).to eq(user)
    end

    it "redirects to edit paper page" do
      do_request
      expect(response).to redirect_to(edit_paper_path Paper.first)
    end
  end

  describe "PUT 'update'" do
    let(:paper) { Paper.create! }

    subject(:do_request) do
      put :update, { id: paper.to_param, paper: { short_title: 'ABC101' } }
    end

    it_behaves_like "when the user is not signed in"

    it_behaves_like "a controller enforcing strong parameters" do
      let(:params_id) { paper.to_param }
      let(:model_identifier) { :paper }
      let(:allowed_params) { ALLOWED_PARAMS }
    end

    it "redirects to dashboard" do
      do_request
      expect(response).to redirect_to(root_path)
    end

    it "updates the paper" do
      do_request
      expect(paper.reload.short_title).to eq('ABC101')
    end
  end

  describe "POST 'upload'" do
    let(:paper) { Paper.create! }

    let(:uploaded_file) do
      double(:uploaded_file, path: '/path/to/file.docx').tap do |d|
        d.stub(:to_param).and_return d
      end
    end

    subject :do_request do
      post :upload, id: paper.to_param, upload_file: uploaded_file
    end

    before do
      DocumentParser.stub(:parse).and_return(title: 'This is a Title About Turtles',
        body: "Heroes in a half shell! Turtle power!")
    end

    it_behaves_like "when the user is not signed in"

    it "redirect to the paper's edit page" do
      do_request
      expect(response).to redirect_to edit_paper_path(paper)
    end

    it "passes the uploaded file's path to the document parser" do
      do_request
      expect(DocumentParser).to have_received(:parse).with(uploaded_file.path)
    end

    it "updates the paper's title" do
      do_request
      expect(paper.reload.title).to eq 'This is a Title About Turtles'
    end

    it "updates the paper's body" do
      do_request
      expect(paper.reload.body).to eq "Heroes in a half shell! Turtle power!"
    end
  end
end
