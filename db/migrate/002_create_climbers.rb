class CreateClimbers < ActiveRecord::Migration[5.2]
    def change
        create_table :climbers do |c|
            c.string :name
            c.integer :age
            c.string :location
            c.integer :skill_level
        end
    end
end