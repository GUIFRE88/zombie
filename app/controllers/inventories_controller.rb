# app/controllers/inventories_controller.rb

class InventoriesController < ApplicationController
  before_action :set_inventory, only: [:destroy]

  def index
    render json: inventory_service.index(params)
  end

  def create
    response = inventory_service.create(inventory_params)
    render json: response
  end

  def destroy
    @inventory.really_destroy!
  end

  private
  
  def set_inventory
    @inventory = Inventory.find_by_id(params[:id])
  end

  def inventory_params
    params.require(:inventory).permit(:item, :point, :user_id)
  end

  def inventory_service
    @inventory_service ||= InventoryService.new
  end

end
