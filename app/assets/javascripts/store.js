(function() {
    function ready() {
        $('.cross-selling .products').owlCarousel({
            // items: 4,
            // itemsDesktop: [1170, 4],
            // itemsDesktopSmall: [970, 3],
            // itemsTablet: [768, 2],
            // itemsMobile: false,
            autoPlay: true
        });
    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
