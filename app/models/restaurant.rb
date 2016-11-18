class Restaurant < ApplicationRecord
  has_many :reviews,
    -> { extending WithUserAssociationExtension }, dependent: :destroy
  validates :name, length: { minimum: 3 }, uniqueness: true

  def build_review(attributes = {}, user)
    attributes[:user] ||= user
    reviews.build(attributes)
  end

  def average_rating
    return 'N/A' if reviews.none?
    return reviews.count
    # reviews.average(:rating)
  end

end
