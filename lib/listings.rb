class Listing

  attr_accessor :title, :list_id, :price, :cash_flow, :url
  @@all = []

  def initialize
    @@all << self
  end

  def self.all
    @@all
  end

  def self.reset_all
    self.all.clear
  end

end

# this is the class to generate listing objects 
