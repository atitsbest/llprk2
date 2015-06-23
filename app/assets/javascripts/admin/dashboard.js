/**
 * Knockout VM für Admin-Dashboard.
 */
define('admin/dashboard', ['jquery', 'knockout'], function($, ko) {
    function VM(settings) {
        var self = this;

    }

    return function(settings) {
        var vm = new VM(settings);
        ko.applyBindings(vm);
    }
});
