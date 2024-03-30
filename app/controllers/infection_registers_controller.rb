# app/controllers/infection_registers_controller.rb

class InfectionRegistersController < ApplicationController
  def create
    begin
      render json: infection_register_service.mark_as_infected(params[:user_id],params[:user_id_infected])
    rescue StandardError => e
      render json: { message: 'Internal Server Error', error: e }, status: '500'  
    end
  end

  private

  def infection_register_service
    @infection_register ||= InfectionRegisterService.new
  end

end
