class CreateClimbs < ActiveRecord::Migration[5.2]
    def change
        create_table :climbs do |c|
            c.integer :route_id
            c.integer :climber_id
            c.integer :rating
            c.string :date_climbed
        end
    end
end