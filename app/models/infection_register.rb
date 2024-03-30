class InfectionRegister < ApplicationRecord
  acts_as_paranoid

  belongs_to :user

  validates :user_id, presence: true
  validates :user_infect_id, presence: true
  validates :user_id, uniqueness: { scope: :user_infect_id, message: "Combinação de user_id e user_infect_id já existe" }
  
  after_create :block_user

  private

  def block_user
    if InfectionRegister.where(user_infect_id: self.user_infect_id).count >= 3
      user = User.find_by_id self.user_infect_id
      user.destroy
    end
  end
end
