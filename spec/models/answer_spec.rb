require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should have_many(:links).dependent(:destroy) }

  it { should have_many_attached(:files) }

  it { should belong_to(:question) }
  it { should belong_to(:author).class_name('User') }

  it { should accept_nested_attributes_for(:links).allow_destroy(true) }

  it { should validate_presence_of(:body) }

  let(:user) { create(:user) }
  let(:answer) { create(:answer, author: user) }

  it { expect(answer.user?(user)).to eq(true) }
end
