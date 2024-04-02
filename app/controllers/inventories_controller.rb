# app/controllers/inventories_controller.rb

class InventoriesController < ApplicationController
  before_action :set_inventory, only: [:destroy]

  def index
    render json: inventory_service.index(params)
  end

  def create
    begin
      response = inventory_service.create(inventory_params)
      render json: response
    rescue StandardError => e
      render json: { message: 'Internal Server Error', error: e }, status: '500'  
    end
  end

  def destroy
    begin
      @inventory.really_destroy!
      render json: { message: 'Inventário excluido com sucesso' }, status: '200'  
    rescue StandardError => e
      render json: { message: 'Internal Server Error', error: e }, status: '500'  
    end
  end

  private
  
  def set_inventory
    @inventory = Inventory.find_by_id(params[:id])
  end

  def inventory_params
    params.require(:inventory).permit(:item, :quantity, :user_id)
  end

  def inventory_service
    @inventory_service ||= InventoryService.new
  end

end
