class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
# edit at 2015-10-11 change redirect_to
#      redirect_to user
      redirect_to controller: 'companies', action: 'index'
    else
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end

