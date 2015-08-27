class CreateUsers < ActiveRecord::Migration
  def up
  	create_table :users do |t|
  		t.string :username
  		t.string :email
      t.string :spotify_uid
  	end
  end

  def down
  	drop_table :users
  end
end
