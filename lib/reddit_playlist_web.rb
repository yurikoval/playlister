require 'dotenv'
Dotenv.load
require 'sinatra/base'

class RedditPlaylistWeb < Sinatra::Base
  get '/*' do
    viewname = params[:splat].first
    "Hello: #{viewname}"
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
