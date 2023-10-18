require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:questions).dependent(:destroy) }
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:authorizations).dependent(:destroy) }
  it { should have_many(:rewards) }

  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:first_name) }

  let!(:user) { create(:user) }

  describe '.find_for_oauth' do
    let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456') }
    let(:service) { double('FindForOauth') }

    it 'calls FindForOauth' do
      expect(FindForOauth).to receive(:new).with(auth).and_return(service)
      expect(service).to receive(:call)
      User.find_for_oauth(auth)
    end
  end

  describe '#is the user an admin?' do
    it 'admin?' do
      user.update(admin: true)
      user.reload

      expect(user.admin?).to eq true
    end
  end
end
