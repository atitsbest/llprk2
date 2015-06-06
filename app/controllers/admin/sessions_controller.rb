class Admin::SessionsController < AdminController
  def new
      render layout: false
  end

  def create
      user = User.find_by_email(params[:email])
      if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect_to :admin_dashboard
      else
          redirect_to :new_admin_session
      end
  end

  def destroy
      session[:user_id] = nil
      redirect_to :new_admin_session
  end
end
