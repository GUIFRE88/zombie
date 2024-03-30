class InfectionRegisterService

  def mark_as_infected(user_id_reporting, user_id_infected)
    register_exist = InfectionRegister.where(user_id: user_id_reporting, user_infect_id: user_id_infected)
    return { status: '422', message: "Esse reporte já foi feito pelo usuário #{user_id_reporting} !" } if register_exist.present?

    infection_register_repository.mark_as_infected(user_id_reporting, user_id_infected)
  end

  private

  def infection_register_repository
    @infection_register_repository ||= InfectionRegisterRepository.new
  end
end