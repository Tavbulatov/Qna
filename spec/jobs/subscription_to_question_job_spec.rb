require 'rails_helper'

RSpec.describe SubscriptionToQuestionJob, type: :job do
  let(:service) { double('SubscriptionToQuestion') }
  let(:question) { create(:question) }

  it 'calls SubscriptionToQuestion#send_notification' do
    allow(SubscriptionToQuestion).to receive(:new).and_return(service)
    expect(service).to receive(:send_notification)

    subject.perform(question)
  end
end
