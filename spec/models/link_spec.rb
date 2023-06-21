require 'rails_helper'

RSpec.describe Link, type: :model do
  it { should belong_to(:linkable) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:url) }
  it { should_not allow_value('example.com').for(:url).with_message('Invalid URL format') }

  let(:user) { create(:user) }
  let(:question) { create(:question, author: user) }
  let(:link) { create(:link,
                       url: 'https://gist.github.com/Tavbulatov/02a8dea29d1bea8671959fb6e7f121cd',
                       linkable: question ) }

  it { expect(link.gist?).to eq(true) }
end
