class Inventory < ApplicationRecord
  acts_as_paranoid

  belongs_to :user

  validates :item, presence: true
  validates :item, inclusion: { in: ['água', 'comida', 'medicamento', 'munição'] }
  validates :point, inclusion: { in: [1, 2, 3, 4] }
  validates :user_id, presence: true
end