
require 'open-uri'
require 'nokogiri'
require 'openssl'
# require 'HTTParty'
require 'csv' #module used to write to csv files
require 'pry'

# from csv module documentation
# CSV.open("path/to/file.csv", "wb") do |csv|
#   csv << ["row", "of", "CSV", "data"]
#   csv << ["another", "row"]
#   # ...
# end


class Scraper
  attr_accessor :data

  def initialize
    self.get_page
  end
  def get_page
    # html = File.read('fixtures/New York Businesses For Sale - BizBuySell.com.html')
    html = File.read('fixtures/softwarebix')
    # html = File.read('fixtures/searchresults')
    # html = File.read('fixtures/new-york-businesses-for-sale')
    # html = File.read('fixtures/new-york-businesses-for-sale2')
    # html = File.read('fixtures/new-york-businesses-for-sale3')
    # html = Nokogiri::HTML(open('https://www.bizbuysell.com/new-york-businesses-for-sale/',{ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}))
    # html = open('https://www.bizbuysell.com/new-york-businesses-for-sale/', {ssl_verify_mode: 0})
    # html = open('https://www.bizbuysell.com/new-york-businesses-for-sale/3/?q=%2fwEFMWNmZnJvbT0yMDAwMDAmY2Z0bz01MDAwMDAmaXI9MSZsc3JfcmxicG49MiZzcGlkPTM%3d')
    @data = Nokogiri::HTML(html)
    #
    # price = data.css("div#resultRowContainer_beforeAd1 a div.priceBlock span.price").text.split("$")
    # project = {
    #   title: data.css("div#resultRowContainer_beforeAd1 a").attribute("title").value,
    #   price: price[1],
    #   cash_flow: price[2],
    #   id: data.css("div#resultRowContainer_beforeAd1 a").attribute("data-listnumber").value
    # }
    #
    # puts project
    # binding.pry
  end

  def get_elements
    projects = {}
    self.data.css("div#resultRowContainer_beforeAd1").each do |project|
      title = self.data.css("div#resultRowContainer_beforeAd1 a").attribute("title").value
      price = self.data.css("div#resultRowContainer_beforeAd1 a div.priceBlock span.price").text.split("$")
      projects[title.to_sym] = {
        title: self.data.css("div#resultRowContainer_beforeAd1 a").attribute("title").value,
        price: price[1]
        cash_flow: price[2]
        id: self.data.css("div#resultRowContainer_beforeAd1 a").attribute("data-listnumber").value
      }
    end
    binding.pry
    projects
  end
end


project = Scraper.new.get_elements
# binding.pry


# div id resultRowContainer_beforeAd1, resultRowContainer_beforeAd2, resultRowContainer_beforeAd3, resultRowContainer_AfterAd3
# div#resultDiv.span10 div.span12 form:nth-child(5) div a div#resultRowContainer_beforeAd1 a

# div#resultDiv.span10 div.span12 form:nth-child(3) => []

# div#resultDiv.span10 div.span12 form div[4]
# div#resultDiv.span10 div.span12 form div a.result.featured
# div#resultDiv.span10 div.span12 form a#List_1360561
# div#resultDiv.span10 div.span12 form div a#List_1360561

# css("a").attribute("data-listnumber").value

# .listingResult.result.featured.indexed

# div.priceBlock

# data.css("div#resultRowContainer_beforeAd1 a").attribute("title").value => post title
# data.css("div#resultRowContainer_beforeAd1 a div.priceBlock span.price").text => gives me price and cash flow, could parse or be more specific
# price.split("$")
# data.css("div#resultRowContainer_beforeAd1 div.priceBlock span.cflow").text =>
