require 'rails_helper'

feature 'User can search for question', "
  In order to find needed question
  As a User
  I'd like to be able to search for the question
" do

  given!(:question) { create(:question, title: 'Test question') }
  given!(:resource_data) { question.title }

  it_behaves_like 'search resource'
end
