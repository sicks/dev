class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]

  before_action :redirect_if_user, only: %i[new create]

  def new
    @user = User.new
  end

  def edit
    @user = Current.user
  end

  def create
    user = User.create!(user_params)

    start_new_session_for user
    redirect_to after_authentication_url, notice: "User Created Successfully"
  end

  def update
    Current.user.update!(user_params)

    redirect_to edit_user_path, notice: "User updated"
  end

  private

  def redirect_if_user
    redirect_to new_session_path, notice: "User limit reached" if User.any?
  end

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation)
  end
end
