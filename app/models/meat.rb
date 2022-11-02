class Meat < ApplicationRecord

  has_many :user_meats
  has_many :posts

end
