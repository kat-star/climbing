class Route < ActiveRecord::Base
  has_many :climbs
  has_many :climbers, through: :climbs

  def self.most_popular
    joins(:climbs).select('routes.*, count(routes.id) as rcount').group('routes.id').order('rcount DESC').first
  end

  def self.find_by_location(input)
    Route.where(location: 'Yosemite').order('routes.name').map do |route| 
      "#{route.name} - Difficulty: #{route.difficulty}, Type: #{route.style}" 
    end
  end

  def self.highest_rated
    routes = joins(:climbs).select('routes.*, avg(climbs.rating) as avg_rating').group('routes.id').order('avg_rating DESC')

    mapped_routes = routes.map do |route| 
      "#{route.name} - Difficulty: #{route.difficulty}, Location: #{route.location}, Style: #{route.style}, Avg Rating: #{route.avg_rating.round(2)}" 
    end
    mapped_routes.take(5)
  end

  def best_climber
    climbers.order(skill_level: :desc).first
  end

  def route_rating_average 
    climbs.average(:rating)
  end

  def self.all_routes_rated
    Route.select('routes.*, avg(climbs.rating) as climb_rating').group('routes.id').joins(:climbs).order('climb_rating DESC').map do |route|
      "#{route.name} - Rating: #{route.climb_rating.round(2)}"
    end
  end

  def self.find_by_route_name(route_name) 
    self.find_by name: route_name
  end

end 
