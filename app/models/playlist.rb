class Playlist < ActiveRecord::Base
  belongs_to :user
  has_many :songs
  
  # -- Functions --

  # Use this function to destroy table rows
  # belonging to the user before the user is
  # deleted
  before_destroy do |playlist|
  	playlist.songs.destroy_all
  end
end