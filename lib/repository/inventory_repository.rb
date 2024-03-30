class InventoryRepository

  def create(inventory_params)
    @inventory = Inventory.new(inventory_params)

    if @inventory.save
      return { inventory: @inventory, message: 'Item criado com sucesso !' }, status: '200'
    else
      return { message: 'Problema ao criar item !' }, status: '422'
    end
  end

  def index(params)
    if params[:user_id].present?
      return Inventory.where(user_id: params[:user_id]).paginate(page: params[:page], per_page: 30)
    else
      return Inventory.all.paginate(page: params[:page], per_page: 30)
    end
  end
end

