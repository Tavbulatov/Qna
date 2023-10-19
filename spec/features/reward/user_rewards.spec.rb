# frozen_string_literal: true

require 'rails_helper'

feature 'Authenticated user sees their rewards', '
  me as the author of the best answer
  I want to see the awards given to me
' do
  given(:user) { create(:user) }
  given!(:reward) { create(:reward, question: create(:question), user: user) }

  scenario 'view awards' do
    sign_in(user)
    click_on 'My awards'
    expect(page).to have_content('MyReward')
    expect(page).to have_css("img[src*='test_image.png']")
  end
end
