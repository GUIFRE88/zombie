class UsersController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
    render json: { message: user_params }, status: :ok
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.permit(:name, :age, :gender, :latitude, :longitude)
  end

end