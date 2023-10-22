# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DailyDigestJob, type: :job do
  let(:service) { double('DailyDigest') }

  it 'calls DailyDigestJob#send_digest' do
    allow(DailyDigest).to receive(:new).and_return(service)
    expect(service).to receive(:send_digest)

    subject.perform_now
  end
end
