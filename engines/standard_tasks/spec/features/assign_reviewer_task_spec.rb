require 'spec_helper'

feature "Assigns Reviewer", js: true do
  let(:journal) { FactoryGirl.create(:journal) }

  let(:editor) { create :user }

  let!(:albert) { create :user }

  let!(:neil) { create :user }

  let!(:paper) do
    FactoryGirl.create :paper, :with_tasks, user: editor, submitted: true, journal: journal,
      short_title: 'foobar', title: 'Foo Bar'
  end

  before do
    assign_journal_role(journal, editor, :editor)
    assign_journal_role(journal, albert, :reviewer)
    assign_journal_role(journal, neil, :reviewer)
    paper_role = create(:paper_role, :editor, paper: paper, user: editor)

    sign_in_page = SignInPage.visit
    sign_in_page.sign_in editor
  end

  scenario "Editor can assign a reviewer to a paper" do
    dashboard_page = DashboardPage.new
    manuscript_page = dashboard_page.view_submitted_paper paper
    manuscript_page.view_card 'Assign Reviewers' do |overlay|
      overlay.paper_reviewers = [albert.full_name, neil.full_name]
      expect(overlay).to have_reviewers(albert, neil)
      # the debounce in the reviewers overlay is causing a race condition between the
      # delayed save and the database truncation during test cleanup.  This will fix it for now.
      sleep 0.2
    end
  end
end