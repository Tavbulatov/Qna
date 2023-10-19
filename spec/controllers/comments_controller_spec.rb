# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, author: user) }
  let!(:comment) { create(:comment, author: user, commentable: question) }

  describe 'POST #create' do
    before { login(user) }

    before do
      post :create, params: { question_id: question, commentable: 'Question', comment: attributes_for(:comment) },
                    format: :json
    end

    context 'create comment' do
      it 'saves a new Comment in the database' do
        expect do
          post :create, params: { question_id: question, commentable: 'Question', comment: attributes_for(:comment) },
                        format: :json
        end.to change(Comment, :count).by(1)
      end

      it 'sets a flash message' do
        expect(flash[:notice]).to eq('You have added a comment')
      end
    end
  end

  describe 'POST #destroy' do
    before { login(user) }

    context 'destruction by the author of the comment' do
      it 'destroy comment' do
        expect { delete :destroy, params: { id: comment }, format: :json }.to change(Comment, :count).by(-1)
      end
    end

    context 'removal of comment by comment author' do
      it 'sets a flash message' do
        delete :destroy, params: { id: comment }, format: :json
        expect(flash[:notice]).to eq('Your comment has been successfully deleted')
      end
    end
  end
end
