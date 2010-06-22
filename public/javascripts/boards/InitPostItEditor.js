var postitManager;

window.addEvent('domready', function() {

    if ( !postitManager ) {
        postitManager = new PostItManager({
            container    : $('container')
        });
    }

    // "Da vida" aos botoes para trocar papel de parede
    $$(".set-background").addEvent("click", function() {
        $('board').setStyles({
            'background-image'  : "url(" + this.get('src') + ")",
            'background-repeat' : this.get('repeat')
        });
    });

    $$(".set-background")[0].fireEvent('click');
});
