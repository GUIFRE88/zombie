class InventoryRepository

  def initialize
    @quantity_enough = true
  end

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

  def exchanges(params, user_first, user_second)
    user_first_items = params[:user_first_items]
    user_second_items = params[:user_second_items]
    
    user_first_points = calculate_points(user_first_items)
    user_second_points = calculate_points(user_second_items)

    begin
      if user_first_points != user_second_points
        return { message: 'A quantidade de pontos não correspondem, portanto não poderá ser feito a troca !' }, status: '422'
      elsif !@quantity_enough
        return { message: 'A quantidade informada não existe no inventário !' }, status: '422'
      else
        remove_itens(items: user_first_items)
        add_itens(user: @user_first, items: user_second_items)

        remove_itens(items: user_second_items)
        add_itens(user: @user_second, items: user_first_items)

        return { message: 'Escambo finalizado com sucesso !' }, status: '200'  
      end
    rescue StandardError => e
      return { message: 'Internal Server Error', error: e }, status: '500'  
    end
  end

  private

  def remove_itens(items:)
    items.each do |id, quantity|
      item = Inventory.find_by_id(id)
      item.quantity -= quantity.to_i
      item.save
    end
  end

  def add_itens(user:, items:)
    items.each do |id, quantity|
      item = Inventory.find_by_id(id)
      item_user = user.inventories.where(item: item.item)&.first
      item_user.quantity += quantity.to_i
      item_user.save
    end
  end

  def calculate_points(items)
    points = 0
    items.each do |id, quantity|
      item = Inventory.find_by_id(id)
      points += item.point * quantity.to_i
      @quantity_enough = false if item.quantity < quantity.to_i
    end
    points
  end

end
