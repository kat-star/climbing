class Route < ActiveRecord::Base
  has_many :climbs
  has_many :climbers, through: :climbs

  def self.who_climbed_me(route)
    
  end


  def self.find_by_location(input)
    result = Route.all.select { |info| info.location == input }
  end
  
  def self.most_popular
    joins(:climbs).select("routes.*, count(routes.id) as rcount").group("routes.id").order("rcount DESC").first
    
  end

  def self.highest_rated
    # sort by highest rating
  end

  def best_climber
    climbers.order(skill_level: :desc).first
  end

  def route_rating_average ##returns a big integer, but it's okay since we'll likely use it as a string for the user
    climbs.average(:rating)
  end

  def self.all_routes_rated ##returns a number
    # ratings = self.all.map { |one_route| one_route.route_rating_average.to_f }

    # routes = self.all.each_with_index.map { |one_route, i|    ##maybe this should go just in the front end??
    #   "#{one_route.name} - Rating: #{ratings[i].round(2)}" 
    #   binding.pry
    # } 
  
    ####  copied from 'most popular'
    joins(:climbs).select("routes.*, count(routes.id) as rcount").group("routes.id").order("rcount DESC")

  end

end 
