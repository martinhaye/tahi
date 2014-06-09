require 'spec_helper'

feature "Profile Page", js: true do
  let(:admin) { create :user, admin: true }

  before do
    sign_in_page = SignInPage.visit
    sign_in_page.sign_in admin
  end

  scenario "the page contains user's info if user is signed in" do
    profile_page = ProfilePage.visit
    expect(profile_page.full_name).to eq admin.full_name
    expect(profile_page.username).to eq admin.username
    expect(profile_page.email).to eq admin.email
    expect(profile_page.affiliations).to match_array admin.affiliations.to_a

    find('a.dropdown-toggle').click
    click_on 'Sign out'
    expect(current_path).to eq new_user_session_path
  end

  scenario "user cannot upload an avatar image of unsupported type" do
    profile_page = ProfilePage.visit
    profile_page.attach_image('about_turtles.docx')
    expect(profile_page).to have_application_error
    expect(profile_page.image).to_not eq('about_turtles.docx')
    expect(profile_page.image).to eq('profile-no-image.png')
  end

  scenario "user can add an affiliation" do
    profile_page = ProfilePage.visit
    profile_page.add_affiliate('Yoda University')
    expect(profile_page.affiliations).to include(/Yoda/)

    expect(profile_page).to have_no_application_error
  end

  scenario "affiliation errors are handled" do
    profile_page = ProfilePage.visit
    profile_page.add_affiliate(' ')
    expect(page).to have_content(/name can't be blank/i)
    expect(profile_page).to have_no_application_error
  end

  scenario "user can delete an affiliation" do
    profile_page = ProfilePage.visit
    profile_page.add_affiliate('Yoda University')
    profile_page.remove_affiliate('Yoda University')
    expect(page).to have_no_content(/Yoda University/)
  end

  describe "canceling affiliation creation" do
    let(:uni) { 'Yoda University' }
    before do
      ProfilePage.visit.set_affiliate(uni)
      find('a', text: 'cancel').click
    end

    it "hides the form" do
      expect(page).to have_no_content(/new affiliation/i)
    end

    it "clears the form" do
      find('a', text: 'Add new').click
      expect(page).to have_no_content(uni)
    end
  end
end
