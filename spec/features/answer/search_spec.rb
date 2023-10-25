require 'sphinx_helper'

feature 'User can search for answer', "
  In order to find needed answer
  As a User
  I'd like to be able to search for the answer
" do

  given!(:answer) { create(:answer, body: 'Test answer') }
  given!(:resource_data) { answer.body }

  it_behaves_like 'search resource'
end
