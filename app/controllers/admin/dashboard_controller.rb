class Admin::DashboardController < AdminController
    before_filter :authorize

    def index
        @products = Product.all
    end
end
