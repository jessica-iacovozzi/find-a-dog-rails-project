class CreateDogs < ActiveRecord::Migration[7.0]
  def change
    create_table :dogs do |t|
      t.string :age_group
      t.string :age
      t.string :breed
      t.string :name
      t.string :picture
      t.string :sex
      t.string :size
      t.string :url
      t.string :latitude
      t.string :longitude
      t.string :organization

      t.timestamps
    end
  end
end
