require 'spec_helper'

describe FilteredUsersSerializer do
  let(:journal) { create :journal }
  let(:paper) { create :paper, journal: journal }
  let(:collaborator) { create :user }
  let(:editor) { create :user }
  let(:reviewer) { create :user }
  let(:users) { [user, collaborator, editor, reviewer] }

  let(:serialized_data) do
    ActiveModel::ArraySerializer.new(users,
      each_serializer: FilteredUsersSerializer,
      paper_id: paper.id).to_json
  end

  let (:roles) do
    JSON.parse(serialized_data).map do |u|
      u["roles"].first
    end
  end

  before do
    create :paper_role, :editor, user: editor, paper: paper
    create :paper_role, :reviewer, user: reviewer, paper: paper
    create :paper_role, :collaborator, user: collaborator, paper: paper

    allow_any_instance_of(FilteredUsersSerializer).to receive(:current_user).and_return(user)
  end

  context "user is site admin" do
    let(:user) { create :user, :site_admin }

    it "serializes all roles" do
      expect(roles).to include("editor", "reviewer", "collaborator")
    end
  end

  context "user is journal admin" do
    let(:user) { create :user }

    before do
      create :role, :admin, users: [user], journal: journal
    end

    it "serializes all roles" do
      expect(roles).to include("editor", "reviewer", "collaborator")
    end

  end

  context "user is neither site nor journal admin" do
    let(:user) { create :user }

    it "serializes only collaborator roles" do
      expect(roles).to include("collaborator")
      expect(roles).to_not include("editor", "reviewer")
    end
  end
end