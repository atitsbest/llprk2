// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.unveil
//= require turbolinks
//= require jquery.readyselector
//= require underscore
//= require knockout-3.2.0
//= require knockout.mapping
//= require knockout.punches
//= require owl.carousel
//= require twitter/bootstrap/collapse
//= require_tree .

// Knockout.Punches:
ko.punches.attributeInterpolationMarkup.enable();
// Enable filter syntax for text, html
ko.punches.textFilter.enableForBinding('text');
ko.punches.textFilter.enableForBinding('html');

/**
 * Nummer als 99.99 € anzeigen.
 *
 * @returns {string}
 */
Number.prototype.toCurrencyString = function() {
    return this.toFixed(2) + ' €';
}
