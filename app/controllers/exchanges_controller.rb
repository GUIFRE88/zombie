# app/controllers/exchanges_controller.rb

class ExchangesController < ApplicationController
  before_action :set_users, only: [:create]

  def create
    render json: inventory_service.exchanges(params, @user_first, @user_second)
  end

  private

  def set_users
    @user_first = User.find(params[:user_first_id])
    @user_second = User.find(params[:user_second_id])
  end

  def inventory_service
    @inventory_service ||= InventoryService.new
  end

end
