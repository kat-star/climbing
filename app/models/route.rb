class Route < ActiveRecord::Base
  has_many :climbs
  has_many :climbers, through: :climbs

end