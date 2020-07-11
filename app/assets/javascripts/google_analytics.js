document.addEventListener('turbolinks:load', function(event) {
    if (typeof gtag === 'function') {
        gtag('config', 'UA-153440725-1', {
            'page_location': event.data.url
        });
    }
});