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

    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
