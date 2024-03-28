# app/models/user.rb
class User < ApplicationRecord
    validates :name, presence: true
    validates :age, numericality: { only_integer: true, greater_than: 0 }
    validates :gender, inclusion: { in: %w[male female other] }
end
  