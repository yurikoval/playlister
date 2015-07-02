class Playlist
  def initialize(args = {})
    args[:privacy_status] ||= 'public'
    @args = args
  end

  delegate :playlist_items, to: :playlist

  def self.find_by_id(playlist_id)
    playlist = new()
    yt_playlist = Yt::Playlist.new(id: playlist_id, auth: playlist.send(:account))
    raise "No Such Playlist" unless yt_playlist.title
    playlist.instance_variable_set(:@playlist, yt_playlist)
    playlist
  end

  def <<(ids = [])
    exisiting_video_ids = playlist_items.map(&:video_id)
    ids_to_add = ids.reject do |add_id|
      exisiting_video_ids.any?{|existing_id| existing_id == add_id}
    end
    @playlist.add_videos ids_to_add
  end

  def id
    playlist.id
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
