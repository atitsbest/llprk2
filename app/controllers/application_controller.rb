class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    ##
    # Liefert zu einem <xx> eine grid-struktur für source.
    ##
    def to_source(relation, ps)
        result = {}
        x = relation
        # Sort
        if ps[:orderBy]
            sort_str = "lower(#{ps[:orderBy]})"
            sort_str += " DESC" if ps[:desc]
            x = x.order(sort_str) 
        end
        result[:total] = x.count
        result[:data] = x.take((ps[:count] || "9999").to_i)
        result[:count] = result[:data].length
        result
    end

    helper_method :current_user
end
