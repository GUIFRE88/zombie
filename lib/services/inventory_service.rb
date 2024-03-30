class InventoryService

  def create(inventory_params)
    inventory_repository.create(inventory_params)
  end

  def index(params)
    inventory_repository.index(params)
  end

  private

  def inventory_repository
    @inventory_repository ||= InventoryRepository.new
  end
end