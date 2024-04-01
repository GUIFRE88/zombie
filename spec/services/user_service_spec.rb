require 'rails_helper'

RSpec.describe UserService, type: :service do
  let(:user_service) { UserService.new }
  let(:user_repository) { instance_double(UserRepository) }
  let(:user) { create(:user) }
  let(:invalid_user_id) { 'invalid_id' }

  describe '#show_user' do
    context 'when user is present' do
      it 'returns the user' do
        expect(user_service.show_user(user)).to eq(user)
      end
    end

    context 'when user is not present' do
      it 'returns a message indicating invalid id' do
        expect(user_service.show_user(nil)).to eq({ message: 'Id não é valido' })
      end
    end
  end

  describe '#create_user' do
    let(:params_user) { { name: 'John', age: 25, gender: 'M' } }

    it 'creates a new user' do
      expect(user_repository).to receive(:create_user).with(params_user)
      user_service.create_user(params_user)
    end
  end

  describe '#update_user' do
    let(:params_user) { { id: user.id, name: 'Updated Name' } }

    it 'updates the user' do
      expect(user_repository).to receive(:update_user).with(params_user)
      user_service.update_user(params_user)
    end
  end

  describe '#destroy_user' do
    context 'when user is present' do
      it 'destroys the user' do
        expect(user_repository).to receive(:destroy_user).with(user)
        user_service.destroy_user(user)
      end
    end

    context 'when user is not present' do
      it 'returns a message indicating user not found' do
        expect(user_service.destroy_user(nil)).to eq({ status: '422', message: 'Usuário não encontrado !' })
      end
    end
  end
end
