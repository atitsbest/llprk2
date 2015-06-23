define('admin/products', ['jquery'], function($) {

    function ready() {
        $('#images').sortable({
            cursor: 'move',
            opacity: 0.5,
            axis: 'x'
        });
    }

    $(document).ready(ready);
    $(document).on('page:load', ready);
});
