class User < ActiveRecord::Base
	has_many :playlists
  # -- Functions --

  # Use this function to destroy table rows
  # belonging to the user before the user is
  # deleted
  before_destroy do |user|
    user.playlists.destroy_all
  end
end