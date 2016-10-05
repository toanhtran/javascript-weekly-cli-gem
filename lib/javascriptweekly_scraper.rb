class JavascriptWeeklyScraper
  attr_accessor :newsletter
  attr_reader :doc

  def initialize(issue_number)
    @newsletter = Newsletter.new
    @newsletter.issue_number = issue_number
    @doc = Nokogiri::HTML(open("http://javascriptweekly.com/issues/#{issue_number}"))
  end

  def scrape

    @newsletter
  end

  def scrape_details
    @newsletter.issue_date = @doc.search("table.gowide.lonmo").text.strip.gsub("Issue #{@issue_number} - ", "").strip
  end
end
