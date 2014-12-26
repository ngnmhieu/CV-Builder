feature "User Dashboard" do
  fixtures :resumes

  scenario "User see Resume Listing" do
    visit '/resumes'
    expect(page).to have_content 'Add New CV'
  end

  scenario "User edit a Resume" do
    visit '/resumes'
    resume = resumes(:one)

    within("tr[id=resume_#{resume.id}]") do
      click_link 'Edit'
    end

    expect(current_path).to eq(edit_resume_path(resume))
  end

  scenario "User delete a Resume" do
    visit '/resumes' 
    resume = resumes(:one)

    within("tr[id=resume_#{resume.id}]") do
      click_link 'Delete'
    end

    expect(current_path).to eq(resumes_path)
  end
end
