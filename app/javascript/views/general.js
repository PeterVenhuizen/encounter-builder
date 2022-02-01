jQuery(function() {
    $(document).on('cocoon:before-remove', function(event, insertedItem) {
        let confirmation = confirm("Are you sure?");
        if (confirmation === false) {
            event.preventDefault();
        } 
    });
});