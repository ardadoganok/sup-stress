window.addEventListener("message", function (event) {
    if (event.data.action == "ui") {
        if (event.data.display) {
            $('.wrapper').css('display', 'block');
            $('.wrapper').fadeIn( event.data.time, function() {
                $('.wrapper').fadeOut( event.data.time, function() {
                    $('.wrapper').css('display', 'none');
                });
            });
        }
    }
});