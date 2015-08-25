class User < ActiveRecord::Base

  # -- Validators --

  # Validate username is present, unique, and  
  # only contains letters and numbers
  validates_uniqueness_of :username, :on => :create
  validates :username, 
    presence: true, 
    format: { with: /\A([a-z]|[1-9])+\Z/i,
    message: "use letters and numbers only" }

  # Validate email is present and follow the
  # format person@example.com
	validates_uniqueness_of :email, :on => :create
  validates :email, 
    presence: true, 
    format: { with: /\S+@\S+\.\S+/i,
    message: "email is not valid" }


  # -- Functions --

  # Use this function to destroy table rows
  # belonging to the user before the user is
  # deleted
  before_destroy do |user|
  end
end