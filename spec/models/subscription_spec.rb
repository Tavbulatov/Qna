# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'associations' do
    it { should belong_to(:subscribed_question).class_name('Question') }
    it { should belong_to(:subscribed_user).class_name('User') }
  end
end
