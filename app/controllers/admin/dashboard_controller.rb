class Admin::DashboardController < AdminController
    before_filter :authorize

    def index
        @products = Product.take(50)
    end
end
