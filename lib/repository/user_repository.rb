class UserRepository

  INVENTORY_ITEMS = [['água', 4], ['comida', 3], ['medicamento', 2], ['munição', 1]] 

  def create_user(params_user)
    user = User.new(params_user)
    if user.save
      create_inventory(user)
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

  def destroy_user(user)
    if user.really_destroy!
      return { status: '200', message: 'Usuário excluído com sucesso !' }
    else
      return { status: '422', message: user.errors }
    end
  end

  def create_inventory(user)
    INVENTORY_ITEMS.each do |item|
      Inventory.create(item: item[0], point: item[1], quantity: 0, user_id: user.id )
    end
  end
end
