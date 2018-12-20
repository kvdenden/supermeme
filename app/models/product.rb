class Product < ApplicationRecord
  has_many :variants

  validates :external_id, presence: true
  validates :title, presence: true
  validates :description, presence: true
end
