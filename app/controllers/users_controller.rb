class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[create]
  before_action :set_user, only: %i[show destroy update]

  # GET /users
  def index
    @user = User.all
    render json: @user
  end

  # GET /users/{username}
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/{username}
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/{username}
  def destroy
    @user.destory
  end

  private

  def user_params
    params.permit(:username, :email, :password, :name, :id)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
