class Climber < ActiveRecord::Base
    has_many :climbs
    has_many :routes, through: :climbs


    def list_most_popular_route

    end

    def retrieve_climbs
        Climb.all.select { |info| info.climber_id == self.id }
    end

    def delete_climb                     ############## coming back to this l8er sk8er!! ###################
        mine = retrieve_climbs
        puts mine
    end                                    ####################  end coming back  ################

    def climbs_by_location(location)
        Route.all.select { |info| info.location == location }
    end

    def climbs_by_my_location
        Route.all.select { |info| info.location == self.location }
    end

end