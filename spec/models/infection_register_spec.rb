require 'rails_helper'

RSpec.describe InfectionRegister, type: :model do

  describe "#Associations" do
    it { should belong_to(:user) }
  end

  describe "validations" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:user_infect_id) }
    it { should validate_uniqueness_of(:user_id).scoped_to(:user_infect_id).with_message("Combinação de user_id e user_infect_id já existe") }
  end

  describe '#block_user' do
    let(:user) { User.create(name: 'Teste1', age: 18, gender: 'H') }
    let(:infected_user) { User.create(name: 'Teste2', age: 18, gender: 'H') }
    let(:infected_user_id) { infected_user.id }

    context 'when user has less than 3 infection registers' do
      it 'does not destroy the user' do
        expect { InfectionRegister.create(user_id: user.id, user_infect_id: infected_user_id) }.to change(User, :count)
      end
    end
  end

end