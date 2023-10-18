require 'rails_helper'

describe 'Profiles API', type: :request do
  let(:headers) { { "CONTENT_TYPE" => "application/json",
                     "ACCEPT" => 'application/json' } }

  describe 'GET api/v1/profiles/me' do
    describe 'unauthorized' do
      it 'returns 401 status if there is no access_token' do
        get '/api/v1/profiles/me', headers: headers
        expect(response.status).to eq 401
      end

      it 'returns 401 status if access_token is invalid' do
        get '/api/v1/profiles/me', params: { access_token: 123456 }, headers: headers
        expect(response.status).to eq 401
      end
    end

    describe 'authorized' do
      let(:me) { create(:user) }
      let(:access_token) {create(:access_token, resource_owner_id: me.id)}

      before { get '/api/v1/profiles/me', params: { access_token: access_token.token },
                                          headers: headers }

      it 'returns 200 status' do
        expect(response).to be_successful
      end

      it 'return all public fields' do
        %i[last_name first_name email created_at updated_at].each do |attr|
          expect(json[attr.to_s]).to eq me.send(attr).as_json
        end
      end

      it 'does not return secret data' do
        %i[password encrypted_password].each do |attr|
          expect(json).to_not have_key(attr.to_s)
        end
      end

      let!(:profiles) { create_list(:user, 2) }

      it 'return all profiles except the current user' do
        get '/api/v1/profiles/all', params: { access_token: access_token.token }, headers: headers

        expect(json).to match_array(profiles.as_json)
      end
    end
  end
end
