class Post < ApplicationRecord

  belongs_to :user
  belongs_to :meat
  has_many :comments,  dependent: :destroy
  has_many :favorites, dependent: :destroy

end
