# frozen_string_literal: true

require 'rails_helper'

feature 'As the creator of the answer and links to it
I want to be able to remove the link I want
' do
  given(:user) { create(:user) }
  given(:question) { create(:question, author: user) }
  given(:answer) { create(:answer, author: user, question: question) }
  given!(:link) { create(:link, linkable: answer) }

  scenario 'delete link', js: true do
    sign_in(user)
    visit question_path(question)

    within '.answers_all' do
      click_on 'Delete link'
    end

    accept_alert 'Are you sure?'
    sleep 1
    within '.answers_all' do
      expect(page).to_not have_link('Google')
    end
  end
end
