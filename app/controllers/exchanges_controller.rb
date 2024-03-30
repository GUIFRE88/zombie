# app/controllers/exchanges_controller.rb

class ExchangesController < ApplicationController
  before_action :set_users, only: [:create]

  def create
    user1_items = params[:user1_items]
    user2_items = params[:user2_items]

    user1_points = calculate_points(user1_items)
    user2_points = calculate_points(user2_items)
    
    begin
      if user1_points != user2_points
        render json: { message: 'A quantidade de pontos não correspondem, portanto não poderá ser feito a troca !' }, status: '422'  
      else
        remove_itens(items: user1_items)
        add_itens(user: @user1, items: user2_items)

        remove_itens(items: user2_items)
        add_itens(user: @user2, items: user1_items)

        render json: { message: 'Escambo finalizado com sucesso !' }, status: '200'  
      end
    rescue StandardError => e
      render json: { message: 'Internal Server Error', error: e }, status: '500'  
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
    end
    points
  end

  def set_users
    @user1 = User.find(params[:user1_id])
    @user2 = User.find(params[:user2_id])
  end

  def inventory_service
    @inventory_service ||= InventoryService.new
  end

end
