class UsersController < ApplicationController
  before_action :require_signed_in, only: [:show]
  before_action :require_signed_out, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = current_user

    render :show
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end