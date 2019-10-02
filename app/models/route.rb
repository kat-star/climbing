class Route < ActiveRecord::Base
  has_many :climbs
  has_many :climbers, through: :climbs

  def best_climber
    climbers.order(skill_level: :desc).first
  end

  def route_rating_average ##returns a big integer, but it's okay since we'll likely use it as a string for the user
    climbs.average(:rating)
  end

  def self.all_routes_rated ##returns a number
    ratings = self.all.map { |one_route| one_route.route_rating_average.to_f }

    routes = self.all.each_with_index.map { |one_route, i| "#{one_route.name} - Rating: #{ratings[i].round(2)}" } ##maybe this should go just in the front end??
  end

end 