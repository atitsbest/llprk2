(function() {
    function ready() {
        $('.cross-selling .products').owlCarousel({
            autoPlay: true
        });

        $('img').unveil(0, function(){
            $(this).load(function(){ 
                this.style.opacity = 1;
            });
        });

    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
})();
