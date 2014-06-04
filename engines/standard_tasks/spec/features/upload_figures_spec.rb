require 'spec_helper'

feature "Upload figures", js: true do
  let(:author) { create :user }
  let(:journal) { create :journal }
  let(:paper) { FactoryGirl.create :paper, :with_tasks, journal: journal, user: author }
  let(:task) do
    FactoryGirl.create(:task, phase: paper.phases.first, type: "StandardTasks::FigureTask")
    StandardTasks::FigureTask.first
  end

  before do
    sign_in_page = SignInPage.visit
    sign_in_page.sign_in author
  end

  scenario "Author uploads figures" do
    edit_paper = EditPaperPage.visit paper

    edit_paper.view_card 'Upload Figures' do |overlay|
      overlay.attach_figure
      expect(overlay).to have_image 'yeti.tiff'
      overlay.mark_as_complete
      expect(overlay).to be_completed
    end

  end

  scenario "Author destroys figure" do
    edit_paper = EditPaperPage.visit paper
    edit_paper.view_card 'Upload Figures' do |overlay|
      overlay.attach_figure
      find('.figure-thumbnail').hover
      find('.glyphicon-trash').click
      find('.figure-delete-button').click
      expect(overlay).to_not have_selector('.figure-image')
    end
  end

  scenario "Author can edit title and caption" do
    edit_paper = EditPaperPage.visit paper
    edit_paper.view_card 'Upload Figures' do |overlay|
      overlay.attach_figure
      title = find('h2.figure-thumbnail-title')
      caption = find('div.figure-thumbnail-caption')

      caption.set 'New figure caption'
      title.set 'new_figure_title'
      all('a', :text => 'SAVE').last.click

      expect(title.text).to eq 'new_figure_title'
      expect(caption.text).to eq 'New figure caption'
    end
  end
end
