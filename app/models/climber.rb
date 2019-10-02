class Climber < ActiveRecord::Base
    has_many :climbs
    has_many :routes, through: :climbs

    def delete

    def list_most_popular_route
        Route.all 
    end

    def retrieve_climbs
        Climb.all.select { |info| info.climber_id == self.id }
    end

    def most_climbed
        routes.most_popular
    end

    def delete_climb                     ############## coming back to this l8er sk8er!! ###################
        mine = retrieve_climbs
        puts mine
    end                                    ####################  end coming back  ################

    def climbs_by_location(location)
        routes.find_by(:location => location)
        # Route.all.select { |info| info.location == location }
    end

    def climbs_by_my_location
        climbs_by_location(self.location)
        # Route.all.select { |info| info.location == self.location }
    end

    def self.helper
        self.all.pluck(:name)
    end
end