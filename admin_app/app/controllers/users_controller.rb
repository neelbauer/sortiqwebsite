class UsersController < ApplicationController
  before_action :require_login
  
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.authenticate(params[:current_password])
      if @user.update(password: params[:new_password], password_confirmation: params[:password_confirmation])
        flash[:notice] = "Password updated successfully"
        redirect_to dashboard_path
      else
        flash.now[:alert] = "New password confirmation doesn't match"
        render :edit
      end
    else
      flash.now[:alert] = "Current password is incorrect"
      render :edit
    end
  end
end
