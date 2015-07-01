define('admin/products/edit', ['jquery', 'jquery-ui-sortable'], function($, sortable) {
    return function() {
        $('#images').sortable({
            cursor: 'move',
            opacity: 0.5,
            axis: 'x'
        });
    };
});
