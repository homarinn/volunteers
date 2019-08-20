require 'rails_helper'

describe Scraping do
  describe "scrape element" do
    it "wishes get text" do
      agent = Mechanize.new
      current_page = agent.get('https://blueshipjapan.com')
      logo_text = current_page.at('//*[@id="masthead"]/h1/strong').inner_text
      expect(logo_text).to include("ゴミ拾い・環境イベントポータルサイト")
    end
  end
  
  describe "auto_update_7:00(JST)" do
    it "wishes update volunteers every 7:00(JST)" do
      travel_to('2019-1-1 22:00'.to_time) do
        expect(Scraping).to receive(:scraping)
      end
    end
  end
end