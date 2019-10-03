class Climb < ActiveRecord::Base
    belongs_to :climber
    belongs_to :route


    def most_popular_climb
        Climb.order(rating:  :desc).first
    end
end