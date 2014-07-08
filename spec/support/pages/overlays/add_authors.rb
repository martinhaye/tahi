class AddAuthorsOverlay < CardOverlay
  def add_author(group_name, author)
    group = find('.author-group', text: group_name)
    within(group) do
      find('.button-secondary', text: "Add new").click
      fill_in_author_form author
      click_button 'done'
    end
    expect(page).to have_no_css('.add-author-form')
  end

  def edit_author(locator_text, new_info)
    page.execute_script "$('.authors-overlay-list li').toggleClass('hover')"
    page.execute_script "$('.authors-overlay-list li:contains(#{locator_text}) .glyphicon-pencil').click()"
    fill_in_author_form new_info
    click_button 'done'
  end

  def delete_author(locator_text)
    page.execute_script "$('.authors-overlay-list li').toggleClass('hover')"
    page.execute_script "$('.authors-overlay-list li:contains(#{locator_text}) .glyphicon-trash').click()"
  end

  def author_groups
    expect(page).to have_css('.author-group')
    all('.author-group')
  end

  private
  def fill_in_author_form(author)
    fill_in "First name", with: author[:first_name]
    fill_in "MI", with: author[:middle_initial]
    fill_in "Last name", with: author[:last_name]
    fill_in "Email", with: author[:email]
    fill_in "Title", with: author[:title]
    fill_in "Department", with: author[:department]
    fill_in "Affiliation", with: author[:affiliation]
    fill_in "Secondary Affiliation", with: author[:secondary_affiliation]
  end
end
