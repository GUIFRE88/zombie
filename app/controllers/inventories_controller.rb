# app/controllers/inventories_controller.rb

class InventoriesController < ApplicationController
  before_action :set_inventory, only: [:destroy]

  def create
    @inventory = Inventory.new(inventory_params)

    if @inventory.save
      render json: { inventory: @inventory, message: 'Item criado com sucesso !' }, status: :created
    else
      render json: @inventory.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @inventory.really_destroy!
  end

  private
    def set_inventory
      @inventory = Inventory.find(params[:id])
    end

    def inventory_params
      params.require(:inventory).permit(:item, :point, :user_id)
    end
end
