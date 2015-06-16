class AdminController < ApplicationController
    protect_from_forgery with: :null_session
    layout 'admin'

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def authorize
        unless current_user
            Rails.logger.info("User not authenticated. Redirecting to login page...")
            redirect_to :new_admin_session unless current_user
        end
    end

    helper_method :current_user
end
