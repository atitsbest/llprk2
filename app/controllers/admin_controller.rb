class AdminController < ApplicationController
    protect_from_forgery with: :null_session
    layout 'admin'
end
