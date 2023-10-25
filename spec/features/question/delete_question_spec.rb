# frozen_string_literal: true

require 'rails_helper'

feature 'Author can delete his question', '
  I am an authorized user
  be on the all questions page
  I have the option to delete my question
  There is no delete button for another user
' do
  given(:user) { create(:user) }
  given(:other_user) { create(:user) }

  describe 'Removal of question' do
    given!(:question) { create(:question, author: user) }
    scenario 'removal of question by its author' do
      sign_in(user)
      click_on 'Delete'
      expect(page).to have_content('Your question has been successfully deleted')
    end


    scenario 'attempt to delete question' do
      sign_in(other_user)
      expect(page).to_not have_link('Delete')
    end
  end

  scenario 'If there are no questions, then there is no "Delete" button' do
    sign_in(user)
    sleep 2
    expect(page).to_not have_link('Delete')
  end
end
