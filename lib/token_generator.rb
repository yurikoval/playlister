class TokenGenerator
  def self.generate
    scopes = %w[youtube youtube.readonly userinfo.email]
    url = Yt::Account.new(scopes: scopes, redirect_uri: ENV['YT_REDIRECT_URI']).authentication_url
    puts url
  end
end
