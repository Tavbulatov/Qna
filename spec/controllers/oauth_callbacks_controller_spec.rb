require 'rails_helper'

RSpec.describe OauthCallbacksController, type: :controller do
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe 'Github' do
    let(:oauth_data) { {'provider' => 'github', 'uid' => 123 } }

    it 'finds user from oauth data' do
      allow(request.env).to receive(:[]).and_call_original
      allow(request.env).to receive(:[]).with('omniauth.auth').and_return(oauth_data)
      expect(User).to receive(:find_for_oauth).with(oauth_data)
      get :github
    end

    context 'user exists' do
      let!(:user) { create(:user) }

      before do
        allow(User).to receive(:find_for_oauth).and_return(user)
        get :github
      end

      it 'login user' do
        expect(subject.current_user).to eq user
      end

      it 'redirects to root path' do
        expect(response).to redirect_to root_path
      end
    end

    context 'user does not exist' do
      before do
        allow(User).to receive(:find_for_oauth)
        get :github
      end

      it 'redirects to root path' do
        expect(response).to redirect_to root_path
      end

      it 'does not login user' do
        expect(subject.current_user).to_not be
      end
    end
  end

  describe 'Vkontakte' do
    let(:auth) { OmniAuth::AuthHash.new(provider: 'vkontakte', uid: 123123)  }

    it 'finds user from oauth data' do
      allow(request.env).to receive(:[]).and_call_original
      allow(request.env).to receive(:[]).with('omniauth.auth').and_return(auth)
      expect(User).to receive(:find_for_oauth).with(auth)
      get :vkontakte
    end

    context 'User registered in the system' do
      let(:user) { create(:user) }

      before do
        allow(request.env).to receive(:[]).and_call_original
        allow(request.env).to receive(:[]).with('omniauth.auth').and_return(auth)
        allow(User).to receive(:find_for_oauth).with(auth).and_return(user)
      end

      it 'The user does not have verified authorization' do
        allow(user.authorizations).to receive_message_chain(:find_by, :confirmed?).and_return(false)
        get :vkontakte

        expect(response).to redirect_to new_authorization_path(provider: auth.provider, uid: auth.uid.to_s)
      end

      it 'The user authorization is confirmed' do
        allow(user.authorizations).to receive_message_chain(:find_by, :confirmed?).and_return(true)
        get :vkontakte

        expect(subject.current_user).to eq user
        expect(response).to redirect_to root_path
      end
    end

    context 'No user' do
      it 'The user is not in the database or the provider did not issue an "email"' do
        allow(request.env).to receive(:[]).and_call_original
        allow(request.env).to receive(:[]).with('omniauth.auth').and_return(auth)
        allow(User).to receive(:find_for_oauth).with(auth)
        get :vkontakte

        expect(response).to redirect_to new_authorization_path(provider: auth.provider, uid: auth.uid.to_s)
      end
    end
  end
end
