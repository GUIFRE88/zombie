require 'rails_helper'

RSpec.describe ReportRepository, type: :repository do
  describe '#report' do
    let(:repository) { described_class.new }

    context 'when generating the report' do
      let!(:user1) { create(:user) }
      let!(:user2) { create(:user) }
      let!(:infected_user) { create(:user, :infected) }
      let!(:deleted_inventory1) { create(:inventory, :deleted, item: 'água', quantity: 3, point: 1) }
      let!(:deleted_inventory2) { create(:inventory, :deleted, item: 'comida', quantity: 5, point: 2) }

      it 'returns the correct report data' do
        report_data, status = repository.report

        expect(status).to eq({:status=>"200"})
        expect(report_data[:percentage_of_infected_users]).to eq('20 %')
        expect(report_data[:percentage_of_uninfected_users]).to eq('80 %')
        expect(report_data[:average_quantity_of_each_item_type_per_user]).to eq({
          water: '0',
          food: '0',
          medicine: '0',
          ammunition: '0'
        })
        expect(report_data[:number_of_points_lost_by_infected_users]).to eq(13)
      end
    end
  end
end
