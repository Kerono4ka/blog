class UserMailer < ApplicationMailer
  default from: "olgha.tovstenko@gmail.com"

  def sample_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Sample Email')
  end
end
