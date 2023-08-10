require 'rails_helper'

feature 'User creates a reward for the best answer', '
  when creating a question
  I, as the author of the question, want to reward the user
  for the best answer to my question
' do
  scenario 'create reward' do
    sign_in(create(:user))
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'

    fill_in 'Reward name', with: 'your award for the best answer'
    attach_file 'Image', "#{Rails.root}/app/assets/images/test_image.png"

    click_on 'Create Question'
    click_on 'Test question'
    click_on 'Reward'

    expect(page).to have_content('your award for the best answer')
    expect(page).to have_css("img[src*='test_image.png']")
  end
end
