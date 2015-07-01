/**
 * Knockout VM für Admin-Produkte.
 */
define('admin/products/index', ['jquery', 'knockout', 'source', 'ko.binding.sorter'], function($, ko, Source) {
    function VM(settings) {
        var self = this;

        self.products = new Source({
            url: settings.productsUrl,
            filter: ko.observable().extend({throttle: 300}),
            sort: {
                by: 'title'
            },
            paging: {
                entriesPerPage: 10
            },
            autoload: true
        });
    }

    return function(settings) {
        var vm = new VM(settings);
        ko.applyBindings(vm);
    }
});

