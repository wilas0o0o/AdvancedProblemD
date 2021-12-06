class Favorite < ApplicationRecord
  belongs_to :book
  belongs_to :user
  
  validates_uniquness_of :book_id,scope: :user_id
end
