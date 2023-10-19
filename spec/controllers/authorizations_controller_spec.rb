# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthorizationsController, type: :controller do
  describe 'POST #create' do
    context 'redirect and flash' do
      before do
        post :create, params: { email: 'alikhantam26@gmail.com', uid: '123123', provider: 'vkontakte' }
      end

      it 'redirect to root_path' do
        expect(response).to redirect_to root_path
      end

      it 'set flash message' do
        expect(flash[:notice]).to eq('Click on the link in the email to confirm authorization')
      end
    end

    context 'create User and Authorization' do
      it 'create a User if it is not in the database' do
        expect do
          post :create,
               params: { email: 'alikhantam26@gmail.com', uid: '123123', provider: 'vkontakte' }
        end.to change(User, :count).by(1)
      end

      it 'create an Authorization if it is not in the database' do
        expect do
          post :create,
               params: { email: 'alikhantam26@gmail.com', uid: '123123', provider: 'vkontakte' }
        end.to change(Authorization, :count).by(1)
      end

      it 'sending confirmation messages' do
        expect do
          post :create,
               params: { email: 'alikhantam26@gmail.com', uid: '123123', provider: 'vkontakte' }
        end.to change(ActionMailer::Base.deliveries, :count).by(1)
      end
    end

    context 'User and Authorization exist' do
      let(:user) { create :user, email: 'alikhantam26@gmail.com' }
      let!(:authorization) { create :authorization, user: user }

      it 'User exist' do
        expect do
          post :create,
               params: { email: user.email, uid: authorization.uid, provider: authorization.provider }
        end.to_not change(User, :count)
      end

      it 'Authorization exist' do
        expect do
          post :create,
               params: { email: user.email, uid: authorization.uid, provider: authorization.provider }
        end.to_not change(Authorization, :count)
      end
    end
  end

  describe 'GET #confirmation' do
    let!(:user) { create :user }
    let!(:authorization) { create :authorization, user: user, confirmation_token: 'qwerty' }

    before do
      get :confirmation,
          params: { authorization_id: authorization, confirmation_token: authorization.confirmation_token }
    end

    it 'sends authorization confirmation email' do
      authorization.reload
      expect(authorization).to be_confirmed
    end

    it 'login user' do
      expect(subject.current_user).to eq(user)
    end

    it 'redirect to root_path' do
      expect(response).to redirect_to root_path
    end
  end
end
