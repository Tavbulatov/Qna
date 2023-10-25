shared_examples_for 'full text search' do
  it "responds to the search method" do
    expect(resource_search).to respond_to(:search)
  end
end
