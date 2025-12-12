class UsersController < ApplicationController
  before_action :require_login
  
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    
    # Handle password change if password fields are present
    if params[:current_password].present?
      if @user.authenticate(params[:current_password])
        if @user.update(password: params[:new_password], password_confirmation: params[:password_confirmation])
          flash[:notice] = "Password updated successfully"
          redirect_to change_password_path
        else
          flash.now[:alert] = "New password confirmation doesn't match"
          render :edit
        end
      else
        flash.now[:alert] = "Current password is incorrect"
        render :edit
      end
    # Handle profile update
    elsif params[:user].present?
      if @user.update(user_params)
        flash[:notice] = "Profile updated successfully"
        redirect_to change_password_path
      else
        flash.now[:alert] = "Failed to update profile"
        render :edit
      end
    else
      flash.now[:alert] = "No data to update"
      render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :company)
  end
end
