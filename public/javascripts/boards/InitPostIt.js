var postitManager;

window.addEvent('domready', function() {
    postitManager = new PostItManager({
        documentName : documentName,
        container    : $('container')
    });
});
