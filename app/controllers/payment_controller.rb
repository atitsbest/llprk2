class PaymentController < ApplicationController
    rescue_from Paypal::Exception::APIError, with: :paypal_api_error

    # Rückkehr von PayPal-Express. Die Bezahlung wurde bereits
    # bei Paypal abgeschlossen.
    def success
        payment = Payment.find_by_token!(params[:token])
        payment.complete!(params[:PayerID])
        flash[:notice] = "Vielen Dank. Ihre Bestellung wurde bezahlt."
    end

    # Wenn die Bezahlung per PayPal abgebrochen wurde.
    def cancel
        payment = Payment.find_by_token!(params[:token])
        payment.cancel!
        flash[:notice] = "Sie haben die Bezahlung per Paypal abgebrochen."

        redirect_to order_edit_url(payment.order)
    end

    private

    def paypal_api_error(e)
        redirect_to order_new_url, flash: { error: e.response.details.collect(&:long_message).join('<br/') }
    end

end
