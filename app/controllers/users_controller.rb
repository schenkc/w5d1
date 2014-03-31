class UsersController < ApplicationController
  before_action :require_signed_in
  before_action :require_signed_out

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in!(@user)
      redirect_to users_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def index
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end