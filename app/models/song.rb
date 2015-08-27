class Song < ActiveRecord::Base
  belongs_to :playlist

  # -- Functions --
end