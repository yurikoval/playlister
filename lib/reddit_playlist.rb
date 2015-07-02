require 'dotenv'
Dotenv.load
require 'active_support/all'
require 'yt'
require 'scraper'
require 'playlist'
require 'token_generator'

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
