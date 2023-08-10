require 'rails_helper'

RSpec.describe Reward, type: :model do
  it { should have_one_attached(:image) }

  it { should belong_to(:question) }
  it { should belong_to(:user).optional(true) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:image) }
end
