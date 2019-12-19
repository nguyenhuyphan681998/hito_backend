class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      respond_to do |format|
        format.html { redirect_to user }
        format.json { render json: { message: 'Login successful' } }
      end
    else
      respond_to do |format|
        flash.now[:danger] = 'Invalid email/password combination'
        format.html {  render 'new' }
        format.json { render json: { message: 'Login failed' } }
      end
    end
  end

  def destroy
    log_out if logged_in?
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { render json: { message: 'Logout successful' } }
    end
  end
end
