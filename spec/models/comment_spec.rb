# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to(:commentable) }
  it { should validate_presence_of(:comment) }

  let(:resource_search) { Comment }
  it_behaves_like 'full text search'
end
