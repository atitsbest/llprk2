(function() {
    function ready() {
        // Cross-selling.
        $('.cross-selling .products').owlCarousel({
            autoPlay: true
        });

        // Bilder aus kleinen Bildschirmen.
        $('.image-xs > ul').owlCarousel();

        $('img').unveil(0, function(){
            $(this).load(function(){
                this.style.opacity = 1;
            });
        });

        // Größere Bilder anzeigen.
        $('#product .images img').on('mouseover', function() {
            var imageUrl = $(this).data('large');

            $('#product .image img').attr('src', imageUrl);
        });

    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
