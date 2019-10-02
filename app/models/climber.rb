class Climber < ActiveRecord::Base
    has_many :climbs
    has_many :routes, through: :climbs

    def delete

end