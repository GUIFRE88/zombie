class UserService

  def show_user(user)
    return user if user.present?
    return { message: 'Id não é valido' }
  end

  def create_user(params_user)
    return user_repository.create_user(params_user)
  end

  def update_user(params_user)
    return user_repository.update_user(params_user)
  end

  def destroy_user(user)
    if user.present?
      return user_repository.destroy_user(user)
    else
      return { status: '422', message: 'Usuário não encontrado !' }
    end
  end

  private

  def user_repository
    @user_repository ||= UserRepository.new
  end

end
