require 'rails_helper'

RSpec.describe Inventory, type: :model do

  describe "#Associations" do
    it { should belong_to(:user) }
  end

  describe "validations" do
    it { should validate_presence_of(:item) }
    it { should validate_inclusion_of(:item).in_array(['água', 'comida', 'medicamento', 'munição']) }
    it { should validate_inclusion_of(:point).in_array([1, 2, 3, 4]) }
    it { should validate_presence_of(:user_id) }
    it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(0) }
  end

end