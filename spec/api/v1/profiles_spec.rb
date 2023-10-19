require 'rails_helper'

describe 'Profiles API', type: :request do
  let(:headers) { { "CONTENT_TYPE" => "application/json",
                     "ACCEPT" => 'application/json' } }

  let(:me) { create(:user) }
  let(:access_token) {create(:access_token, resource_owner_id: me.id)}

  describe 'GET api/v1/profiles/me' do
    let(:api_path) { '/api/v1/profiles/me' }
    let(:method) { :get }

    it_behaves_like 'API Authorizable'

    context 'authorized' do
      before { get api_path, params: { access_token: access_token.token },
                                          headers: headers }

      it_behaves_like 'API return status'

      it 'return all public fields' do
        %w[last_name first_name email created_at updated_at].each do |attr|
          expect(json[attr]).to eq me.send(attr).as_json
        end
      end

      it 'does not return secret data' do
        %w[password encrypted_password].each do |attr|
          expect(json).to_not have_key(attr)
        end
      end
    end
  end

  describe 'GET api/v1/profiles/all' do
    let(:api_path) { '/api/v1/profiles/all' }
    let(:method) { :get }

    it_behaves_like 'API Authorizable'

    context 'authorized' do
      let!(:profiles) { create_list(:user, 2) }

      before { get api_path, params: { access_token: access_token.token }, headers: headers }

      it_behaves_like 'API return status'

      it 'return all profiles except the current user' do
        expect(json).to match_array(profiles.as_json)
        expect(json).to_not include(me)
      end
    end
  end
end
