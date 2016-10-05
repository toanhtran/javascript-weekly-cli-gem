class JavascriptWeeklyScraper

  def initialize(issue_number)
    @newletter = Newsletter.new
    @newsletter.issue_number = issue_number
    @doc = Nokogiri::HTML(open("http://javascriptweekly.com/issues/#{issue_number}"))
  end

end
