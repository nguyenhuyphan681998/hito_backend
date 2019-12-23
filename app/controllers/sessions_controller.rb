class SessionsController < ApplicationController
  def new
  end

  def create
    if request.env['omniauth.auth']
      user = User.create_with_omniauth(request.env['omniauth.auth'])
      log_in user
      respond_to do |format|
        format.html { redirect_to root_url }
        format.json { render json: { message: 'Login successful' } }
      end
    else
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        if user.activated?
          log_in user
          params[:session][:remember_me] == '1' ? remember(user) : forget(user)
          respond_to do |format|
            format.html { redirect_to root_url }
            format.json { render json: { message: 'Login successful' } }
          end
        else
          message = "Account not activated. "
          message += "Check your email for the activation link"
          flash[:warning] = message
          respond_to do |format|
            format.html { redirect_to root_url }
            format.json { render json: { message: 'Account not activated' } }
          end
        end
      else
        respond_to do |format|
          flash.now[:danger] = 'Invalid email/password combination'
          format.html {  render 'new' }
          format.json { render json: { message: 'Login failed' }, status: :unauthorized }
        end
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
