require 'sphinx_helper'

RSpec.describe SearchController, type: :controller do
  describe 'GET #search' do
    it 'renders search view' do
      get :search, params: { resource: 'Question', query: 'test' }, format: :js
      expect(response).to render_template :search
    end

    it 'redirect to root path' do
      get :search, params: { resource: 'Question', query: nil }, format: :js
      expect(response).to redirect_to root_path
    end

    it 'the Question model calls the search method' do
      expect(Question).to receive(:search)
      get :search, params: { resource: 'Question', query: 'test'}
    end

    it 'the Answer model calls the search method' do
      expect(Answer).to receive(:search)
      get :search, params: { resource: 'Answer', query: 'test' }
    end

    it 'ThinkingSphinx calls the search method' do
      expect(ThinkingSphinx).to receive(:search)
      get :search, params: { resource: 'all', query: 'test' }
    end
  end
end
