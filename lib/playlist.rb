class Playlist
  def initialize(args = {})
    args[:privacy_status] ||= 'public'
    @args = args
  end

  delegate :playlist_items, to: :playlist

  def self.find_by_id(playlist_id)
    playlist = new()
    playlist.instance_variable_set(:@playlist, Yt::Playlist.new(id: playlist_id, auth: playlist.send(:account)))
    playlist
  end

  def <<(ids = [])
    @playlist.add_videos ids
  end

  def id
    account.id
  end

  private
    def account
      # @account ||= Yt::Account.new(authorization_code: ENV['YOUTUBE_AUTHORIZATION_CODE'], redirect_uri: ENV['YT_REDIRECT_URI'])
      @account ||= Yt::Account.new(access_token: ENV['YOUTUBE_ACCESS_TOKEN'])
    end

    def playlist
      @playlist ||= account.create_playlist(@args)
    end
end
