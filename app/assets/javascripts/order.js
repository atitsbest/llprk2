$('.orders.new, .orders.create').ready(function() {
    var $shippingCosts = $('.summary .shipping-cost span'),
        $countrySelect = $('#order_country_id'),
        $subTotal = $('.summary .sub-total span'),
        $total = $('.summary .total span');

    // Liefer die Vesandkosten für das aktuell ausgewählte Land.
    var _shippingCosts = function() {
        var newId = $countrySelect.val();
        return shipping_costs[newId];
    };

    // Versandtkosten anhand des ausgewählten Landes aktualisieren.
    var _updateShippingCosts = function() {
        var costs = _shippingCosts();

        $shippingCosts.html(costs.toCurrencyString());
    };

    // Gesamtpreis auktualisiren.
    var _updateTotalPrice = function() {
        var costs = _shippingCosts(),
            sub_total = parseFloat($subTotal.data('value'));

        $total.html((sub_total + costs).toCurrencyString());
    };

    // Events:
    $countrySelect.on('change', function() {
        _updateShippingCosts();
        _updateTotalPrice();
    });

    // Gleich mal die Versandkosten für das aktuelle Land anzeigen.
    _updateShippingCosts();
    _updateTotalPrice();
});
