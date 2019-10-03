class Climber < ActiveRecord::Base
    has_many :climbs
    has_many :routes, through: :climbs

    def list_most_popular_route
        Route.all 
    end

    def retrieve_climbs
        my_climbs = climbs.pluck(:route_id)
        my_info = Route.select { |one_route| my_climbs.include?(one_route.id)}
        dates = climbs.map { |climb| climb.date_climbed}

        my_info.each_with_index.map { |info, i| "#{info.name} - #{dates[i]}" }
    end

    def most_climbed
        routes.most_popular
    end

    def delete_climb(input)  
        num_delete = input.to_i - 1
        climbs[num_delete].destroy
    end                                    

    def update_climb(input)
        num_update = input.to_i - 1
        puts "You can update your climb rating. What is the new rating (1-5)?"
        climb_rating =  STDIN.getch
        climbs[num_update].update(rating: :climb_rating)
        puts "Your climb rating has been updated to #{climb_rating}."
    end

    def climbs_by_location(location)
        routes.find_by(:location => location)
    end

    def self.climbers_by_route_location(location)
        Climber.select("climbers.*").distinct.joins(:routes).where("routes.location = ?", location).map do |climber|
            "Climber Name: #{climber.name}, Age: #{climber.age}, Their Location: #{climber.location}, Skill Level: #{climber.skill_level}"
        end
    end

    def climbs_by_my_location
        climbs_by_location(self.location)
    end

    def self.helper
        self.all.pluck(:name)
    end

end