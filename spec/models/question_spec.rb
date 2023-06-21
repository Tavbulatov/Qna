require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:links).dependent(:destroy) }

  it { should have_one(:reward).dependent(:destroy) }

  it { should have_many_attached(:files) }

  it { should belong_to(:author).class_name('User') }
  it { should belong_to(:best_answer).class_name('Answer').optional(true)  }

  it { should accept_nested_attributes_for(:reward).allow_destroy(true) }
  it { should accept_nested_attributes_for(:links).allow_destroy(true) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }

  let(:user) { create(:user) }
  let(:question) { create(:question, author: user) }

  it { expect(question.user?(user)).to eq(true) }
end
