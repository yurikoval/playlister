describe Scraper, :vcr do
  context "with post"
    let(:post_url) { '/r/listentothis/comments/3batbp/the_story_so_far_high_regard_pop_punk_2011/' }
    subject(:scraper) { Scraper.new post_url }

    it "initializes client" do
      expect(scraper.send(:client)).to be_signed_in
    end

    it "gets post_id" do
      expect(scraper.send(:post_id)).to eq "3batbp"
    end

    it "gets comments" do
      comments = scraper.send(:comments)
      expect(comments).to be_a Array
      expect(comments.first).to be_a RedditKit::Comment
      expect(scraper.send(:text_comments).count).to eq 41
    end

    it "extracts youtube ids" do
      expect(scraper.youtube_ids).to eq %w[h3L-xm7bs34 6DlYETRuZuQ zGeBffMzxPs G-yt7yUNvlQ Y2E0Qz3WIqc q3ARZTR_Ju8 _NrCpSC2TEw 7KJKTvbk_Us]
    end
end
