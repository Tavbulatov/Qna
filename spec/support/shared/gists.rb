shared_examples_for 'gists extract from links' do
  context 'gists_url' do
    it { expect(resource.gists_url).to match_array(link_gists.map(&:url)) }
  end

  context 'gists_id' do
    it { expect(resource.gists_id).to match_array(link_gists.map(&:id)) }
  end

  context 'gists' do
    it { expect(resource.gists).to match_array(link_gists) }
  end
end
