require 'rails_helper'

RSpec.describe InfectionRegisterRepository, type: :repository do
  describe '#mark_as_infected' do
    let(:repository) { described_class.new }

    context 'when the infection register is successfully created' do
      let(:user_id_reporting) { 1 }
      let(:user_id_infected) { 2 }
      
      before do
        allow_any_instance_of(InfectionRegister).to receive(:save).and_return(true)
      end

      it 'returns a success message' do
        expect(repository.mark_as_infected(user_id_reporting, user_id_infected)).to eq({ status: '200', message: "Usuário #{user_id_infected} marcado como infectado com sucesso !" })
      end
    end

    context 'when the infection register fails to save' do
      let(:user_id_reporting) { 1 }
      let(:user_id_infected) { 2 }
      let(:infection_register) { instance_double(InfectionRegister, errors: { field: ['error message'] }) }

      before do
        allow(InfectionRegister).to receive(:new).and_return(infection_register)
        allow(infection_register).to receive(:save).and_return(false)
      end

      it 'returns an error message' do
        expect(repository.mark_as_infected(user_id_reporting, user_id_infected)).to eq({ status: '422', message: { field: ['error message'] } })
      end
    end
  end
end
