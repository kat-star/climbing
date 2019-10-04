class Climber < ActiveRecord::Base
  has_many :climbs
  has_many :routes, through: :climbs

  def retrieve_climbs
    climbs.includes(:route).order('routes.name').map do |climb|
      "#{climb.route.name} - Date Climbed: #{climb.date_climbed}, My Rating: #{climb.rating}"
    end
  end

  def delete_climb(input)  
    num_delete = input.to_i - 1
    if climbs.length == 0
      'There are no climbs to delete.'
    else
      climbs[num_delete].destroy
    end
  end                                    

  def update_climb(input, rating)
    input = input.to_i - 1
    climbs[input].update(rating: rating)
    puts "Your climb rating has been updated to #{rating}."
  end

  def climbs_by_location(location)
    routes.find_by(:location => location)
  end

  def self.climbers_by_route_location(location)
      Climber.select('climbers.*').distinct.joins(:routes).where('routes.location = ?', location).map do |climber|
          "#{climber.name} - Age: #{climber.age}, Their Location: #{climber.location}, Skill Level: #{climber.skill_level}"
      end
  end

  def climbs_by_my_location
      climbs_by_location(self.location)
  end

end