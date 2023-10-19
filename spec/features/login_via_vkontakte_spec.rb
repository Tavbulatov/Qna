# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'VKontakte', type: :feature do
  scenario 'can sign in user with Vkontakte account' do
    visit new_user_session_path
    click_on 'Sign in with Vkontakte'

    fill_in 'Email', with: 'alikhantam26@gmail.com'

    click_on 'Send'
    open_email('alikhantam26@gmail.com')
    current_email.click_link 'Confirm'

    expect(current_email.subject).to eq('Authorization confirmation')
    expect(page).to have_content('You have confirmed your authorization')
    expect(page).to have_current_path(root_path)
  end

  given(:user) { create(:user) }
  given!(:authorization) { create(:authorization, user: user, confirmed_at: Date.current) }

  scenario 'the user is authenticated once and does not need to enter an email address' do
    mock_auth_hash_vkontakte
    visit new_user_session_path
    click_on 'Sign in with Vkontakte'

    expect(page).to have_content('Successfully authenticated from Vkontakte account.')
    expect(page).to have_current_path(root_path)
  end
end
