class JavascriptWeeklyScraper
  attr_accessor :newsletter, :doc

  def initialize(issue_number)
    @newsletter = Newsletter.new
    @newsletter.issue_number = issue_number
    @doc = Nokogiri::HTML(open("http://javascriptweekly.com/issues/#{issue_number}"))
  end

  def scrape
    scrape_details
    scrape_articles
    @newsletter
  end

  def scrape_details
    @newsletter.issue_date = @doc.search("table.gowide.lonmo").text.strip.gsub("Issue #{@issue_number} - ", "").strip
  end

  def scrape_articles
    @doc.search("td[align='left'] div")[1..-1].each do |article_table|
      a = Article.new
      a.author = article_table.search("div:last").text.strip
      a.title = article_table.search("a:first").text.strip
      a.url = article_table.search("a:first").attr("href").text.strip

      @newsletter.add_article(a)
    end
  end
end
