class Review < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user
  validates :rating, inclusion: (1..5)
  validates :user, uniqueness: { scope: :restaurant, message: "has reviewed this restaurant already" }


  def can_delete?(current_user, review)
    review.user_id == current_user.id ? true : false
  end
end
