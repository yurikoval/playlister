require 'redditkit'
class Scraper
  def initialize(url)
    @url = url
  end

  def youtube_ids
    text_comments.join.scan(/(?:https?:\/\/)?(?:youtu\.be\/|(?:www\.)?youtube\.com\/watch(?:\.php)?\?.*v=)([a-zA-Z0-9\-_]+)/).uniq.flatten
  end

  private
    def post_id
      @url.match(/comments\/([^\/]+)\//)[1]
    end

    def comments
      @comments ||= client.comments(post_id, {depth: 100})
    end

    def text_comments
      comments.map do |comment|
        extract_links(comment)
      end.flatten
    end

    def extract_links(comment)
      [comment.body] + comment.replies.map do |c|
        extract_links c
      end
    end

    def client
      @client ||= RedditKit::Client.new ENV['REDDIT_USERNAME'], ENV['REDDIT_PASSWORD']
    end
end
