require 'rails_helper'

feature 'I, as a user, would like to comment on the question and, as the author of the question, respond to comments
' do

  given(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }

  scenario 'create comment', js: true do
    sign_in(user)
    visit question_path(question)
    sleep 1

    within('.question_show') do
      fill_in 'Comment', with: 'Interesting question'
    end
    click_on 'Create Comment'
    sleep 1
    expect(page).to have_content('Interesting question')
  end

  given!(:comment) {create(:comment, author: user, commentable: question)}

  scenario 'delete comment', js: true do
    sign_in(user)
    visit question_path(question)
    sleep 1
    click_on 'Delete comment'
    sleep 1
    expect(page).to_not have_content('MyComment')
  end

  scenario 'when you create a comment, it appears on another user’s page', js: true  do
    Capybara.using_session('user') do
      sign_in(user)
      visit question_path(question)
      sleep 0.5

      within('.question_show') do
        fill_in 'Comment', with: 'Interesting question'
        click_on 'Create Comment'
      end

    end

    Capybara.using_session('guest') do
      visit question_path(question)
      expect(page).to have_content 'Interesting question'
    end
  end
end
