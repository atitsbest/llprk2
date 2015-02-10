$('.cart.show').ready(function() {
    function ShowViewModel() {
        var self = this;

        self.lineItems = ko.observableArray();

        self.subTotal = ko.pureComputed(function() {
            return _.reduce(self.lineItems(), function(m, x) { return m + x.qty * x.price; }, 0);
        });

        $.when($.getJSON('cart')).then(function(data) {
            self.lineItems(data.line_items)
        })
        .fail(function() { alert('Warenkorb konnte nicht geladen werden!'); });
    }

    vm = new ShowViewModel();
    ko.applyBindings(vm);
});
