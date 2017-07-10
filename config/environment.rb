require 'nokogiri'
require 'open-uri'
require 'csv' #module used to write to csv files
require 'pry'

# from csv module documentation
# CSV.open("path/to/file.csv", "wb") do |csv|
#   csv << ["row", "of", "CSV", "data"]
#   csv << ["another", "row"]
#   # ...
# end
