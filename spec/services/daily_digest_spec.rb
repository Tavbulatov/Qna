# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DailyDigest do
  let(:users) { create_list(:user, 3) }

  it 'send daily digest to all users' do
    users.each do |user|
      expect(DailyDigestMailer).to receive(:digest).with(user).and_call_original
    end

    subject.send_digest
  end
end
