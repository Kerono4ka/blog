class UsersController < ApplicationController
  skip_before_action :authorize, only: [:create, :new]
  
  def show 
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to login_path
    else  
      render 'new'      
    end
  end

  def update
    @user = current_user
    params_to_update = user_params
    params_to_update.delete(:password) if params_to_update[:password].blank?

    if @user.update_attributes(params_to_update)
      redirect_to users_show_path
    else
      render 'edit'
    end
  end

  def destroy
    @user = current_user
    if @user.destroy
      drop_session
      flash[:success] = "Successfully deleted!"
      redirect_to login_path
    else
      flash[:error] = "Something went wrong, the user wasn't deleted"
      redirect_to users_show_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :login, :email, :password, :password_confirmation, :avatar)
  end
end
