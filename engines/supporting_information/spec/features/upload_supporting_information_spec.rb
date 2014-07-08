require 'spec_helper'

feature "Upload Supporting Information", js: true do
  let(:author) { create :user }
  let(:journal) { create :journal }
  let(:paper) { FactoryGirl.create :paper, :with_tasks, journal: journal, user: author }

  before do
    sign_in_page = SignInPage.visit
    sign_in_page.sign_in author

    allow(SupportingInformation::DownloadSupportingInfo).to receive(:enqueue) do |supporting_info_id, url|
      supporting_info = SupportingInformation::File.find(supporting_info_id)
      supporting_info.save
    end

  end

  scenario "Author uploads supporting information" do
    edit_paper = EditPaperPage.visit paper

    edit_paper.view_card('Supporting Info', SupportingInformationOverlay) do |overlay|
      overlay.attach_supporting_information
      expect(overlay).to have_file 'yeti.jpg'
    end
  end

  scenario "Author destroys supporting information immediately" do
    edit_paper = EditPaperPage.visit paper
    edit_paper.view_card('Supporting Info', SupportingInformationOverlay) do |overlay|
      overlay.attach_supporting_information
      find('.figure-thumbnail').hover
      find('.glyphicon-trash').click
      find('.figure-delete-button').click
      expect(overlay).to_not have_selector('.figure-image')
    end
  end

  scenario "Author can edit title and caption" do
    paper.supporting_information_files.create
    edit_paper = EditPaperPage.visit paper
    edit_paper.view_card('Supporting Info', SupportingInformationOverlay) do |overlay|
      title = find('h2.figure-thumbnail-title')
      caption = find('div.figure-thumbnail-caption')

      caption.set 'New file caption'
      title.set 'new_file_title'
      all('a', :text => 'Save').last.click

      expect(title.text).to eq 'new_file_title'
      expect(caption.text).to eq 'New file caption'
    end

    file = paper.supporting_information_files.last
    expect(file.title).to eq 'new_file_title'
    expect(file.caption).to eq 'New file caption'
  end
end
