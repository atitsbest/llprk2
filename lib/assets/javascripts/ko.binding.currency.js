define('ko.binding.currency', ["jquery", "knockout"], function ($, ko) {
    ko.bindingHandlers.currency = {
        init: function(element, valueAccessor, allBindings, viewModel, bindingContext) {

        },
        update: function(element, valueAccessor, allBindings, viewModel, bindingContext) {
            console.log(valueAccessor);
            var val = ko.utils.unwrapObservable(valueAccessor()),
                fmt = (parseFloat(val) || 0).toFixed(2),
                result = fmt + " €";

            $(element).html(result);
        }
    };
});
