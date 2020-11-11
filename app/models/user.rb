class User < ApplicationRecord
  has_many :sales, class_name: 'Transaction', foreign_key: :seller_id
  has_many :purchases, class_name: 'Transaction', foreign_key: :buyer_id

  has_many :sold_recipes, through: :sales, source: :recipe
  has_many :purchased_recipes, through: :purchases, source: :recipe

  scope :sellers, -> { joins(:sales) }
  scope :buyers, -> { joins(:purchases) }

  has_secure_password
end
