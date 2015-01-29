(function() {
    function ready() {
        $('.cross-selling').owlCarousel({
            items: 4,
            itemsMobile: false,
            autoPlay: true
        });
    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
