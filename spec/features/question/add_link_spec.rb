# frozen_string_literal: true

require 'rails_helper'

feature 'When creating a question, I want to attach links
I can add links dynamically on button click
If I attached a link not to the point, then I see a link with the name of the link
' do
  scenario 'create link', js: true do
    sign_in(create(:user))
    click_on 'Ask question'
    sleep 0.5
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'

    click_on 'Add link'

    fill_in 'Name', with: 'Google'
    fill_in 'Url', with: 'https://google.com'

    click_on 'Create Question'
    sleep 0.5
    click_on 'Test question'
    sleep 1

    within('.links') do
      expect(page).to have_link('Google')
    end
  end
end
