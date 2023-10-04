require 'rails_helper'

RSpec.feature 'Github', type: :feature do

  scenario 'can sign in user with Github account' do
    mock_auth_hash_github
    visit new_user_session_path
    click_on 'Sign in with GitHub'
    expect(page).to have_content('Successfully authenticated from Github account')
    expect(page).to have_current_path(root_path)
  end
end
