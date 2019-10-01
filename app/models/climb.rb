class Climb < ActiveRecord::Base
    belongs_to :climbers
    belongs_to :routes
end