require 'rails_helper'

RSpec.describe ReportRepository, type: :repository do
  describe '#report' do
    let(:repository) { described_class.new }

    context 'when generating the report' do
      let!(:user1) { create(:user) }
      let!(:user2) { create(:user) }
      let!(:infected_user) { create(:user, :infected) }
      let!(:deleted_inventory1) { create(:inventory, :deleted, item: 'Água', quantity: 3, point: 1) }
      let!(:deleted_inventory2) { create(:inventory, :deleted, item: 'Comida', quantity: 5, point: 2) }

      it 'returns the correct report data' do
        report_data, status = repository.report

        expect(status).to eq('200')
        expect(report_data[:percentage_of_infected_users]).to eq('25 %')
        expect(report_data[:percentage_of_uninfected_users]).to eq('75 %')
        expect(report_data[:average_quantity_of_each_item_type_per_user]).to eq({
          water: '1',
          food: '1',
          medicine: '0',
          ammunition: '0'
        })
        expect(report_data[:number_of_points_lost_by_infected_users]).to eq(11)
      end
    end
  end
end
