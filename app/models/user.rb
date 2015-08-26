class User < ActiveRecord::Base
  # -- Functions --

  # Use this function to destroy table rows
  # belonging to the user before the user is
  # deleted
  before_destroy do |user|
  end
end