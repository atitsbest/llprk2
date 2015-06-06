class Admin::DashboardController < AdminController
    before_filter :authorize

    def index
    end
end
