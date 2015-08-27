class CreateSongs < ActiveRecord::Migration
	def up
  	create_table :songs do |t|
  		t.string :name
  		t.string :album
  		t.string :artist
  		t.string :spotify_id
  	end
  end

  def down
  	drop_table :songs
  end
end
