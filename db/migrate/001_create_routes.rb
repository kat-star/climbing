class CreateRoutes < ActiveRecord::Migration[5.2]
  def change
    create_table :routes do |t|
      t.string :name
      t.integer :difficulty
      t.string :location
      t.string :style
    end
  end
end