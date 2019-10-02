class Route < ActiveRecord::Base
  has_many :climbs
  has_many :climbers, through: :climbs

  def self.most_popular
    joins(:climbs).select("routes.*, count(routes.id) as rcount").group("routes.id").order("rcount DESC")
  end

  def self.highest_rated
    # sort by highest rating
  end
end