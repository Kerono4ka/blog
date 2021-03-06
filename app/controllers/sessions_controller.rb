class SessionsController < ApplicationController
  skip_before_action :authorize

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id

      UserMailer.with(user: user).sample_email.deliver_now
      
      redirect_to params[:return_url], notice: "Logged in!"
    else
      flash[:error] = "Email or password is invalid!"
      render "new"
    end
  end

  def destroy
    drop_session
    redirect_to root_url, notice: "Logged out!"
  end
end
