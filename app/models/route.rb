class Route < ActiveRecord::Base
  has_many :climbs
  has_many :climbers, through: :climbs

  def climbers #returns a list of climbers who have climbed this route instance
    Climb.all.select { |a| a.route_id == self.id }
  end

  def names_of_routes #returns just a name of the routes
    Route.all.map { |routy| routy.name }
  end

  def best_climber
    Climb.all.find do|climber| 
      climber
      binding.pry
  end


  SELECT routes.id, AVG(climbs.rating) FROM 


end