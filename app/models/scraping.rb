class Scraping
  def self.scraping
    moshicom_scraping
    blueshipjapan_scraping
  end

  def self.moshicom_scraping
    volunteers_urls(
      host_url: 'https://moshicom.com',
      search_url: "https://moshicom.com/search/?keywords=&date_start=&date_end=&disciplines[8]=11&scale=0&sort=2&disp_limit=20&mode=1&fbclid=IwAR36bNd1om-WzjvdoSIguJ-982WYHp7PjH2mVk5GBmfU6I5d9f21pudQR1k",
      volunteer_element: '.event-title a',
      title_element: '.card-title',
      summary_element: '.card-text',
      location_element: '//*[@id="main"]/section/div/div[1]/div/article/section[2]/div/table/tbody/tr[3]/td',
      date_element: '//*[@id="main"]/section/div/div[1]/div/article/section[1]/div[1]/div[3]/table/tbody/tr[1]/td',
      next_element: '//*[@id="all-search-results"]/div[3]/div/nav/nav/ul/li[7]/a',
      organizer_element: '//*[@id="main"]/section/div/div[1]/div/article/section[2]/div/table/tbody/tr[10]/td'
    )
  end
  
  def self.blueshipjapan_scraping
    volunteers_urls(
      host_url: 'https://blueshipjapan.com',
      search_url: "https://blueshipjapan.com/search/event/catalog?area=0&text_date=&date=1&text_keyword=&cancelled=1&order=desc&fbclid=IwAR2lqspX-GFLqYSawsuplc0G_TQBsRfrR2aawooRRyWdjh2Vb0Vdddda_nY",
      volunteer_element: '.event_title a',
      title_element: '#main_content h1',
      summary_element: '//*[@id="main_content"]/div[2]/div[1]/div[3]/div/p',
      location_element: '//*[@id="main_content"]/div[2]/div[1]/div[2]/p[2]',
      date_element: '//*[@id="main_content"]/div[2]/div[1]/div[1]/div[1]/p[2]',
      next_element: "//*[@id='search_result']/div/div/div/a[contains(text(), '>')]",
      organizer_element: '//*[@id="main_content"]/div[2]/div[2]/table/tbody/tr[10]/td/a'
    )
  end

  private

  def self.volunteers_urls(
    host_url:, 
    search_url:,
    volunteer_element:, 
    title_element:, 
    summary_element:, 
    location_element:, 
    date_element:,
    next_element:,
    organizer_element: nil
  )
    links = []
    agent = Mechanize.new

    while true
      current_page = agent.get(search_url)
      break unless current_page
      elements = current_page.search(volunteer_element)
      elements.each do |ele|
        links << ele.get_attribute('href')
      end

      next_link = current_page.at(next_element)
      break unless next_link
      link = next_link.get_attribute('href')
      search_url = make_search_url(link, host_url)

    end

    links.each do |link|
      search_url = make_search_url(link, host_url)
      fetch_volunteer(
        search_url,
        title_element,
        summary_element,
        location_element,
        date_element,
        organizer_element
      )
    end
  end

  def self.make_search_url(link, host_url)
    link.include?("http") ? link : host_url + link
  end

  def self.fetch_volunteer(
    url,
    title_element,
    summary_element,
    location_element,
    date_element,
    organizer_element
  )
    agent = Mechanize.new
    page = agent.get(url)
    volunteer_datas = {
      title: fetch_title_or_summary(page, title_element),
      summary: fetch_title_or_summary(page, summary_element),
      location: fetch_location_or_date(page, location_element),
      date: fetch_location_or_date(page, date_element)
    }

    organizer = page.at(organizer_element).inner_text if page.at(organizer_element)
    if Organization.find_by(name: organizer)
      organization = Organization.find_by(name: organizer)
      organization_id = organization.id
    else
      organization_id = nil
    end

    volunteer = Volunteer.where(volunteer_datas).first_or_initialize
    volunteer.organization_id = organization_id
    volunteer.save
  end

  def self.fetch_title_or_summary(page, element)
    page.at(element).inner_text.gsub(/[\r\n]/,"") if page.at(element)
  end

  def self.fetch_location_or_date(page, element)
    page.at(element).inner_text.gsub(/\r\n|\r|\n|\s|\t/, "") if page.at(element)
  end
end