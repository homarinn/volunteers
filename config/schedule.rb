require File.expand_path(File.dirname(__FILE__) + "/environment")
set :output, "#{Rails.root}/log/crontab.log"
set :environment, :development

every 1.day, :at => '10:00 pm' do
  runner "Scraping.scraping"
end