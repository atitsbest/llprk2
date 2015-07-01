define('ko.binding.currency', ["jquery", "knockout"], function ($, ko) {
    ko.bindingHandlers.currency = {
        init: function(element, valueAccessor, allBindings, viewModel, bindingContext) {
            console.log(valueAccessor);

        },
        update: function(element, valueAccessor, allBindings, viewModel, bindingContext) {
            console.log(valueAccessor);
            var val = ko.utils.unwrapObservable(valueAccessor)()();

            var fmt = val.toFixed(2),
            result = fmt + " €";


            $(element).value(result);
        }
    };
});
