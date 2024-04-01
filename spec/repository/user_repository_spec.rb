require 'rails_helper'

RSpec.describe UserRepository, type: :repository do
  describe '#create_user' do
    let(:repository) { described_class.new }

    context 'when creating a user with valid parameters' do
      let(:params_user) { attributes_for(:user) }

      it 'creates a new user and inventory items' do
        expect { repository.create_user(params_user) }.to change(User, :count).by(1)
                                                       .and change(Inventory, :count).by(UserRepository::INVENTORY_ITEMS.size)
        user = User.last
        expect(user.name).to eq(params_user[:name])
        expect(user.age).to eq(params_user[:age])
        expect(user.gender).to eq(params_user[:gender])
        expect(user.latitude).to eq(params_user[:latitude])
        expect(user.longitude).to eq(params_user[:longitude])
      end

      it 'returns a success message and status 200' do
        result = repository.create_user(params_user)
        expect(result[:status]).to eq('200')
        expect(result[:message]).to eq('Usuário criado com sucesso !')
      end
    end

    context 'when creating a user with invalid parameters' do
      let(:params_user) { { name: '' } } # Invalid parameters

      it 'does not create a new user' do
        expect { repository.create_user(params_user) }.not_to change(User, :count)
      end

      it 'returns an error message and status 422' do
        result = repository.create_user(params_user)
        expect(result[:status]).to eq('422')
        expect(result[:message]).to include(:name)
      end
    end
  end

  # Similar tests for '#update_user' and '#destroy_user' methods can be written
end
