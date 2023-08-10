require 'rails_helper'

feature 'When creating a question, I want to attach links
I can add links dynamically on button click
If I attached a link to an entity, then I see the output of the entity on the page and the name of the link
' do
  scenario 'create link', js: true do
    sign_in(create(:user))
    click_on 'Ask question'
    sleep 0.5
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'

    click_on 'Add link'

    fill_in 'Name', with: 'Gist'
    fill_in 'Url', with: 'https://gist.github.com/Tavbulatov/789ad83d7cf2f60d151b915f9b34a025'

    click_on 'Create Question'
    sleep 0.5
    click_on 'Test question'
    sleep 1

    within('.links') do
      expect(page).to have_content('Gist')
      expect(page).to have_content('asd')
      expect(page).to have_content('123')
    end
  end
end
