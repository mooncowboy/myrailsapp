class CreateArtists < ActiveRecord::Migration[7.0]
  def change
    create_table :artists do |t|
      t.string :spotify_id
      t.string :name
      t.integer :popularity

      t.timestamps
    end
  end
end
