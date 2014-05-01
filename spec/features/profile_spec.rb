require 'spec_helper'

feature "Profile Page", js: true do
  let(:admin) { create :user }

  before do
    sign_in_page = SignInPage.visit
    sign_in_page.sign_in admin.email
  end

  scenario "the page contains user's info if user is signed in" do
    profile_page = ProfilePage.visit
    expect(profile_page.user_full_name).to eq admin.full_name
    expect(profile_page.username).to eq admin.username
    expect(profile_page.email).to eq admin.email
    expect(profile_page.affiliations).to match_array [admin.affiliation]

    find('a.dropdown-toggle').click
    click_on 'Sign out'
    expect(current_path).to eq new_user_session_path
  end

  scenario "user can upload an avatar image" do
    profile_page = ProfilePage.visit
    profile_page.attach_image('yeti.jpg')
    expect(profile_page.image).to eq('yeti.jpg')
    expect(profile_page.image_size).to eq('160x160')

    profile_page.reload
    expect(profile_page.image).to eq('yeti.jpg')
    expect(profile_page.image_size).to eq('160x160')
  end
end
