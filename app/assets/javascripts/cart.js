// cart/show
$('.cart.show').ready(function() {
    function ShowViewModel() {
        var self = this;

        // Die Bestellzeilen.
        self.lineItems = ko.observableArray();

        // Zwischensumme (ohne Versandkosten) für den Warenkorb.
        self.subTotal = ko.pureComputed(function() {
            return _.reduce(self.lineItems(), function(m, x) { return m + x.qty() * x.price; }, 0);
        });

        // Anzahl der Artikel (berücksichtigt qty).
        self.productCount = ko.pureComputed(function() {
            return _.reduce(self.lineItems(), function(m, x) { return m + x.qty(); }, 0);
        });


        // Warenkorbdaten vom Server laden.
        $.when($.getJSON('cart')).then(function(data) {
            self.lineItems(_(data.line_items).map(function(li) {
                return _.extend(li, {
                    // Die Anzahl muss überwacht werden.
                    qty: ko.observable(li.qty),
                    // Zwischensumme dieser Bestellzeile.
                    sum: ko.pureComputed(function(){
                        return this.price * this.qty();
                    }, li),
                    incQty: function(){
                       this.qty(this.qty() + 1);
                    }.bind(li),
                    decQty: function(){
                        this.qty(Math.max(1, this.qty() - 1));
                    }.bind(li),

                });
            }));
        })
        .fail(function() { alert('Warenkorb konnte nicht geladen werden!'); });
    }

    vm = new ShowViewModel();
    ko.applyBindings(vm);
});
