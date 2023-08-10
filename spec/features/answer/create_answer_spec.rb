require 'rails_helper'

feature 'User can create answer', '
  I am an authorized user
  Being on the list of questions page I can answer the question
  I can answer the question on the question page
' do
  given(:user) { create(:user) }
  given!(:question) { create(:question) }

  describe 'Authenticated user', js: true do
    background { sign_in(user) }
    background { visit question_path(question) }

    scenario 'creating an answer on the question page' do
      fill_in 'Body', with: 'answer to question'
      click_on('Create Answer')

      sleep 0.5
      expect(page).to have_content('answer to question')
      expect(page).to have_content('Answer created successfully')
    end

    scenario 'creating a answer with adding files' do
      fill_in 'Body', with: 'answer to question'
      attach_file 'Files', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
      click_on('Create Answer')
      sleep 1
      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end

    scenario 'creating an answer with a link' do
      fill_in 'Body', with: 'answer to question'

      click_on 'Add link'

      fill_in 'Name', with: 'Google'
      fill_in 'Url', with: 'https://google.com'

      click_on 'Create Answer'
      sleep 1

      within('.answers') do
        expect(page).to have_link('Google')
      end
    end

    scenario 'creating an answer with a link to the gist' do
      fill_in 'Body', with: 'answer to question'

      click_on 'Add link'

      fill_in 'Name', with: 'Gist'
      fill_in 'Url', with: 'https://gist.github.com/Tavbulatov/789ad83d7cf2f60d151b915f9b34a025'

      click_on 'Create Answer'
      sleep 1

      within('.answers') do
        expect(page).to have_content('Gist')
        expect(page).to have_content('asd')
        expect(page).to have_content('123')
      end
    end
  end
end
