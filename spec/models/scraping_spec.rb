require 'rails_helper'

describe Scraping do
  describe "auto_update_7:00(JST)" do
    it "wishes update volunteers every 7:00(JST)" do
      travel_to('2019-1-1 22:00'.to_time) do
        expect(Scraping).to receive(:scraping)
      end
    end
  end
end