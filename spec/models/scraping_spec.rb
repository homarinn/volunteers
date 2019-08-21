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

  describe "#volunteer_save" do
    let(:volunteer) { create(:volunteer) }
    let(:organization) { create(:organization) }

    it "can't be created volunteer without title" do
      expect{create(:volunteer, title: nil)}.to raise_error
    end

    it "is created if data is not in tables" do
      sample_datas = {
        title: "sample_title",
        summary: "sample_summary",
        location: "sample_location",
        date: "sample_date",
        organization_id: organization.id
      }
      sample = Volunteer.where(sample_datas).first_or_initialize
      expect{sample.save}.to change(Volunteer, :count).by(1)
    end

    it "is updated if data is in tables" do
      copy_datas = {
        title: volunteer.title,
        summary: volunteer.summary,
        location: volunteer.location,
        date: volunteer.date
      }  
      copy = Volunteer.where(copy_datas).first_or_initialize
      copy.organization_id = organization.id
      copy.save
      sample = Volunteer.find(volunteer.id)
      expect(sample.organization_id).to eq copy.organization_id
    end
  end
  
  describe "auto_update_7:00(JST)" do
    it "wishes update volunteers every 7:00(JST)" do
      # travel_to('2019-1-1 22:00'.to_time) do
      #   expect(Scraping).to receive(:scraping)
      # end
    end
  end
end