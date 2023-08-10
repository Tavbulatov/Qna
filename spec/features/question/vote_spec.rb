require 'rails_helper'

feature 'User vote', '
I am an authenticated user
I can vote up or down.
' do
  given(:author) { create(:user) }
  given(:user) { create(:user) }
  given(:question) { create(:question, author: author) }

  describe 'Vote', js: true do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'up vote' do
      click_on 'Up'
      sleep 1
      expect(page).to have_link('Cancel vote')
      expect(page).to_not have_button('Down')
      expect(page).to_not have_button('Up')
      expect(page).to have_content 'Your vote has been counted'
    end

    scenario 'down vote' do
      click_on 'Down'
      sleep 1
      expect(page).to have_link('Cancel vote')
      expect(page).to_not have_button('Down')
      expect(page).to_not have_button('Up')
      expect(page).to have_content 'Your vote has been counted'
    end

    scenario "buttons are visible if the user hasn't voted yet" do
      expect(page).to have_button('Down')
      expect(page).to have_button('Up')
    end

    scenario 'if the user votes and unvotes, the up and down buttons appear' do
      click_on 'Down'
      sleep 1
      click_on 'Cancel vote'
      expect(page).to have_button('Down')
      expect(page).to have_button('Up')
      expect(page).to have_content 'You deleted your vote'
    end
  end

  scenario 'the author of the question cannot upvote his own question', js: true do
    sign_in(author)
    visit question_path(question)

    expect(page).to_not have_button('Down')
    expect(page).to_not have_button('Up')
  end

  scenario 'unauthenticated user does not see voting buttons', js: true do
    visit question_path(question)

    expect(page).to_not have_button('Down')
    expect(page).to_not have_button('Up')
  end
end
