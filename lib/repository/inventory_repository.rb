class InventoryRepository

  def create(inventory_params)
    inventory = Inventory.where(item: inventory_params[:item], user_id: inventory_params[:user_id])&.first
    inventory.quantity += inventory_params[:quantity] if inventory.present?

    if inventory.present? && inventory.save
      return { inventory: inventory, message: 'Quantidade adicionada com sucesso no inventário !' }, status: '200'
    else
      return { message: 'Problema ao adicionar o item no inventário !' }, status: '422'
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

{
"item":"comida",
"user_id":23,
"quantity": 2
}

