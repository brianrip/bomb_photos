class Studio < ActiveRecord::Base
  has_many :photos
  has_many :users

  enum status: %w(active inactive pending denied)
end
