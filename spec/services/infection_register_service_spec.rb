require 'rails_helper'

RSpec.describe InfectionRegisterService, type: :service do
  let(:infection_register_service) { described_class.new }
  let(:infection_register_repository) { instance_double(InfectionRegisterRepository) }
  let(:user_id_reporting) { 1 }
  let(:user_id_infected) { 2 }

  describe '#mark_as_infected' do
    context 'when the infection register does not exist' do
      before do
        allow(InfectionRegister).to receive(:where).and_return([])
      end

      it 'marks the user as infected' do
        expect(infection_register_repository).to receive(:mark_as_infected).with(user_id_reporting, user_id_infected)
        expect(infection_register_service.mark_as_infected(user_id_reporting, user_id_infected)).not_to eq({ status: '422', message: "Esse reporte já foi feito pelo usuário #{user_id_reporting} !" })
      end
    end

    context 'when the infection register already exists' do
      before do
        allow(InfectionRegister).to receive(:where).and_return([instance_double(InfectionRegister)])
      end

      it 'returns an error message' do
        expect(infection_register_service.mark_as_infected(user_id_reporting, user_id_infected)).to eq({ status: '422', message: "Esse reporte já foi feito pelo usuário #{user_id_reporting} !" })
      end
    end
  end
end
