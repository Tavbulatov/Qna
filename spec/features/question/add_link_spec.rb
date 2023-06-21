require 'rails_helper'

feature 'When creating a question, I want to attach links
If I attached a link to the essence, then I see the output of the essence on the page and the name of the link
If I attached a link not to a gist, then I see a link with the name of the link
' do

  given(:url) { "https://gist.github.com/Tavbulatov/789ad83d7cf2f60d151b915f9b34a025" }
  given(:url2) { "https://google.com" }

  scenario 'create link', js: true  do
    sign_in(create(:user))
    click_on 'Ask question'
    sleep 0.5
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'

    fill_in 'Name', with: 'Gist'
    fill_in 'Url', with: url

    fill_in 'Name', with: 'Google'
    fill_in 'Url', with: url2

    click_on 'Create Question'
    sleep 0.5
    click_on 'Test question'
    sleep 1

    within('.links') do
      expect(page).to have_content('Gist')
      expect(page).to have_content('asd')
      expect(page).to have_content('123')

      expect(page).to have_link('Google')
    end
  end
end
