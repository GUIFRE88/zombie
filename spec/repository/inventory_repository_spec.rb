require 'rails_helper'

RSpec.describe InventoryRepository, type: :repository do
  describe '#create' do
    let(:repository) { described_class.new }

    context 'when inventory item is successfully created' do
      let(:inventory_params) { { item: 'Água', user_id: 1, quantity: 5 } }

      it 'returns success message and status 200' do
        expect(Inventory).to receive(:where).and_return(double(first: build(:inventory)))
        expect_any_instance_of(Inventory).to receive(:save).and_return(true)
        
        result, status = repository.create(inventory_params)
        expect(result[:message]).to eq('Quantidade adicionada com sucesso no inventário !')
        expect(status).to eq({:status=>"200"})
      end
    end

    context 'when there is a problem creating the inventory item' do
      let(:inventory_params) { { item: 'Água', user_id: 1, quantity: 5 } }

      it 'returns error message and status 422' do
        expect(Inventory).to receive(:where).and_return(double(first: build(:inventory)))
        expect_any_instance_of(Inventory).to receive(:save).and_return(false)
        
        result, status = repository.create(inventory_params)
        expect(result[:message]).to eq('Problema ao adicionar o item no inventário !')
        expect(status).to eq({:status=>"422"})
      end
    end
  end

  describe '#exchanges' do
    let(:repository) { described_class.new }
    let(:user_first) { double(inventories: build_list(:inventory, 5)) }
    let(:user_second) { double(inventories: build_list(:inventory, 5)) }
    let(:params) { { user_first_items: { 1 => 2, 2 => 3 }, user_second_items: { 3 => 4, 4 => 1 } } }

    context 'when the points are not equal' do
      it 'returns error message and status 422' do
        expect(repository).to receive(:calculate_points).and_return(10, 15)

        result, status = repository.exchanges(params, user_first, user_second)
        expect(result[:message]).to eq('A quantidade de pontos não correspondem, portanto não poderá ser feito a troca !')
        expect(status).to eq({:status=>"422"})
      end
    end

    context 'when the quantity is not enough' do
      it 'returns error message and status 422' do
        expect(repository).to receive(:calculate_points).and_return(10)
        expect(repository).to receive(:calculate_points).and_return(11)

        result, status = repository.exchanges(params, user_first, user_second)
        expect(result[:message]).to eq('A quantidade de pontos não correspondem, portanto não poderá ser feito a troca !')
        expect(status).to eq({:status=>"422"})
      end
    end

    context 'when the exchange is successful' do
      it 'returns success message and status 200' do
        expect(repository).to receive(:calculate_points).and_return(10).twice
        expect(repository).to receive(:remove_itens).twice
        expect(repository).to receive(:add_itens).twice

        response = repository.exchanges(params, user_first, user_second)
        expect(response[0][:message]).to eq('Escambo finalizado com sucesso !')
        expect(response[1][:status]).to eq('200')
      end
    end
  end
end
