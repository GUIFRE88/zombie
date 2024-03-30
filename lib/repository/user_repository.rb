class UserRepository

  def create_user(params_user)
    user = User.new(params_user)
    if user.save
      return { status: '200', user: user, message: 'Usuário criado com sucesso !' }
    else
      return { status: '422', message: user.errors }
    end
  end

  def update_user(params_user)
    user = User.find_by_id(params_user[:id])
    if user.present?
      user.name = params_user[:name] if params_user[:name].present?
      user.age = params_user[:age] if params_user[:age].present?
      user.gender = params_user[:gender] if params_user[:gender].present?
      user.latitude = params_user[:latitude] if params_user[:latitude].present?
      user.longitude = params_user[:longitude] if params_user[:longitude].present?
      if user.save
        return { status: '200', user: user, message: 'Usuário alterado com sucesso !' }
      end
    end
    return { status: '422', message: 'Não foi possível alterar o usuário !' }
  end
end
