# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.
task scrape: :environment do
  puts 'FETCHING LISTINGS'

  #require 'OpenURI.open'

  URL = 'https://www.indeed.com/jobs?q=internship&l=United+States'
  doc = Nokogiri::HTML(URI.open(URL))
  postings = doc.search('div.jobsearch-SerpJobCard')
  num = 0
  page = 1

  while num <= 240
    pagination_url = "https://www.indeed.com/jobs?q=internship&l=United+States&start=#{num}"
    puts ''
    puts pagination_url
    puts "Page: #{page}"
    doc = Nokogiri::HTML(URI.open(pagination_url))
    postings = doc.search('div.jobsearch-SerpJobCard')
    postings.each do |p|
      job_title = p.search('h2 a')[0].attributes["title"].value.gsub(/\n/, "")
      company = p.search('span.company').text.gsub(/\n/, "")
      location1 = p.search('div.location').text.gsub(/\n/, "")
      location2 = p.search('span.location').text.gsub(/\n/, "")
      location = location1 + location2
      summary = p.search('div.summary').text.gsub(/\n/, "")
      url = "https://indeed.com" + p.search('h2 a')[0].attributes["href"].value.gsub(/\n/, "")

      # skip persisting job if it already exists in db
      if Job.where(job_title:job_title, company:company, location:location, summary:summary, url:url).count <= 0
        Job.create(
          job_title:job_title,
          company:company,
          location:location,
          summary:summary,
          url:url)

        puts 'Added: ' + (job_title ? job_title : '')
      else
        puts 'Skipped: ' + (job_title ? job_title : '')
      end

    end
    num += 10
    page += 1
  end

end
# div.location
# <div class="location accessible-contrast-color-location">New York, NY</div>