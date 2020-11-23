class RestaurantOwner < ActiveRecord::Base
  validates :name, presence: true
  has_many :restaurants
end
