class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy]

  def index
    render json: User.all.paginate(page: params[:page], per_page: 30)
  end

  def show
    render json: user_service.show_user(@user)
  end

  def create
    response = user_service.create_user(user_params)
    render json: { user: response[:user], message: response[:message] }, status: response[:status]
  end

  def update
    response = user_service.update_user(params)
    render json: { user: response[:user], message: response[:message] }, status: response[:status]
  end

  def destroy
    @user.really_destroy! if @user.present?
  end

  private

  def set_user
    @user = User.find_by_id(params[:id]) if params[:id].present?
  end

  def user_params
    params.require(:user).permit(:name, :age, :gender, :latitude, :longitude)
  end

  def user_service
    @user_service ||= UserService.new
  end

end