# app/models/user.rb
class User < ApplicationRecord
  acts_as_paranoid

  validates :name, presence: true
  validates :age, numericality: { only_integer: true, greater_than: 0 }
  validates :gender, inclusion: { in: %w[H M O] }

  has_many :inventories, dependent: :destroy
  has_many :infection_registers, foreign_key: :user_id, dependent: :destroy
end
  