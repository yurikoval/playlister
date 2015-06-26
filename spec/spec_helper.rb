require 'pry'
require 'vcr'
require 'reddit_playlist'
VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.default_cassette_options = {
    record: ENV.fetch('RECORD'){ :once }.to_sym,
    match_requests_on: [:method, :path, :query, :body],
  }
  c.ignore_localhost = true
  c.configure_rspec_metadata!
  c.filter_sensitive_data('<REDDIT_USERNAME>') { ENV['REDDIT_USERNAME'] }
  c.filter_sensitive_data('<REDDIT_PASSWORD>') { ENV['REDDIT_PASSWORD'] }
end
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
