class InventoryService

  def create(inventory_params)
    inventory_repository.create(inventory_params)
  end

  def index(params)
    inventory_repository.index(params)
  end

  def exchanges(params, user_first, user_second)
    inventory_repository.exchanges(params, user_first, user_second)
  end

  private

  def inventory_repository
    @inventory_repository ||= InventoryRepository.new
  end
end