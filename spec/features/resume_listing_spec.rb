feature "User Dashboard" do
  scenario "User see Resume Listing" do
    visit '/resumes'
    expect(page).to have_content 'Add New CV'
  end
end
