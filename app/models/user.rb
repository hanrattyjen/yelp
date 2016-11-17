class User < ApplicationRecord
 has_many :reviews
 has_many :restaurants
 has_many :reviewed_restaurants, through: :reviews, source: :restaurant
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  def has_reviewed?(restaurant)
   reviewed_restaurants.include? restaurant
  end

  def build_restaurant(attributes = {}, user)
    attributes[:user_id] ||= user.id
    restaurants.build(attributes)
  end

  def can_delete?(current_user, restaurant)
    restaurant.user_id == current_user.id ? true : false
  end

  def can_edit?(current_user, restaurant)
    restaurant.user_id == current_user.id ? true : false
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
  end
 end
end
