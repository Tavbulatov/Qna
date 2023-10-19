# frozen_string_literal: true

shared_examples_for 'API return status' do
  it 'returns 200 status' do
    expect(response).to be_successful
  end
end
