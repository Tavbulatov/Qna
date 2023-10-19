# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Authorization, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:provider) }
  it { should validate_presence_of(:uid) }

  describe 'Confirmation' do
    let(:user) { create(:user) }
    let(:authorization) { create(:authorization, user: user) }

    it 'confirmed?' do
      expect(authorization.confirmed?).to eq(authorization.confirmed_at)
    end

    it 'confirm!' do
      authorization.confirm!
      expect(authorization.confirmed_at.to_date).to eq(Date.current)
    end
  end
end
