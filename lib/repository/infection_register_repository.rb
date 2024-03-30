class InfectionRegisterRepository

  def mark_as_infected(user_id_reporting, user_id_infected)
    infection_register = InfectionRegister.new(user_id: user_id_reporting, user_infect_id: user_id_infected)
    if infection_register.save
      return { status: '200', message: "Usuário #{user_id_infected} marcado como infectado com sucesso !" }
    else
      return { status: '422', message: infection_register.errors }
    end
  end
end
