describe Playlist, :vcr do
  let(:playlist_id) { 'PLcQuLA5Ps-q5ceV_jIX5p9bL8X7zm2A0C' }
  it "gets account id" do
    p = Playlist.new title: 'Test title'
    expect(p.send(:account).id).to eq '115790085790434106631'
  end

  it 'gets playlist id' do
    playlist = Playlist.find_by_id playlist_id
    expect(playlist.id).to eq playlist_id
  end

  it "creates new playlist" do
    playlist = Playlist.new title: 'Test title'
    expect(playlist.playlist_items.count).to eq 0
    playlist << %w[h3L-xm7bs34 6DlYETRuZuQ zGeBffMzxPs G-yt7yUNvlQ]
    expect(playlist.playlist_items.count).to eq 4
  end

  it "retrieves playlist" do
    playlist = Playlist.find_by_id playlist_id
    expect(playlist.playlist_items.count).to eq 4
  end

  it "adds unique ids" do
    playlist = Playlist.find_by_id playlist_id
    playlist << %w[h3L-xm7bs34]
    expect(playlist.playlist_items.count).to eq 4
  end
end
