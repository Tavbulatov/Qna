require 'rails_helper'

feature 'As the creator of the question and links to it
I want to be able to remove the link I want
' do

  given(:user) { create(:user) }
  given(:question) {create(:question, author: user) }
  given!(:link) {create(:link, linkable: question) }

  scenario 'delete link', js: true  do
    sign_in(user)
    visit question_path(question)

    click_on 'Delete link'
    accept_alert 'Are you sure?'

    within('.links') do
      expect(page).to_not have_link('Google')
    end
  end
end
