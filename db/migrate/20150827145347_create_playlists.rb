class CreatePlaylists < ActiveRecord::Migration
  def up
  	create_table :playlists do |t|
  		t.string :name
  		t.integer :user_id
  	end
  end

  def down
  	drop_table :playlists
  end
end
