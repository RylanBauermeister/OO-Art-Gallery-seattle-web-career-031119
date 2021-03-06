require "pry"
class Artist
  attr_reader :name, :years_experience

  @@all = []

  def initialize(name, years_experience)
    @name = name
    @years_experience = years_experience
    self.class.all << self
  end

  def create_painting(title, price, gallery)
    Painting.new(title, price, self, gallery)
  end

  def paintings
    Painting.all.select{|painting| painting.artist == self}
  end

  def galleries
    self.paintings.map{|painting| painting.gallery}
  end

  def cities
    self.galleries.map{|gallery| gallery.city}
  end

  def self.total_experience
    @@all.reduce(0){|acc, artist| acc += artist.years_experience}
  end

  def self.most_prolific
    @@all.max_by{|artist|
      artist.paintings.count.to_f / artist.years_experience}
  end

  def self.all
    @@all
  end

end
