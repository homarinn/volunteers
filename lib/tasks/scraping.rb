require "#{Rails.root}/app/models/scraping"

class Tasks::Scraping
  def self.scrape
    puts "start"
    Scraping.scraping
  end
end