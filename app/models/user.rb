class User < ActiveRecord::Base
  validates_presence_of :username, :password
  has_secure_password
  has_many :videogame_systems
  has_many :videogames
end