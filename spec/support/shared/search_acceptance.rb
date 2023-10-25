shared_examples_for 'search resource' do
  scenario 'User looking for information', sphinx: true do
    visit questions_path

    ThinkingSphinx::Test.run do

      fill_in "query", with: resource_data

      click_on "Search"

      sleep 1
      expect(page).to have_content resource_data
    end
  end
end
