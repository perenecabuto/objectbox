var PostItHelper = new Class({

    animate: function( postit ) {
        var _this   = this;
        var element = postit.getElement();

        // Faz com que postit flutue dentro do container
        element.makeDraggable({
            precalculate : true,
            handle       : postit.getDragElement(),
            container    : postit.getContainer(),
            onSnap       : function(element, droppable, event){
                element.fireEvent('click');

                if ( element.retrieve('resizing') ) {
                    this.stop()
                }
            }
        });

        // Torna o postit redimensionável
        element.makeResizable({
            handle : postit.getResizeElement(),
            onSnap : function(element, droppable, event){
                element.store('resizing', true);
            },
            onComplete : function(element, droppable, event){
                element.store('resizing', false);
            }
        });

        // Faz com que postit fique a frente quando clicado
        element.addEvent('click', function() {
            $$('.postit').setStyle('z-index', '1');
            this.setStyle('z-index', '2');
        });

        // Altera titulo com clique duplo
        postit.getDragElement().addEvent('dblclick', function() {
            var text  = this.getElement('.postit-title').get('text') || new Date().format("%d de %B de %Y %H:%M:%S ");

            postit.makeEditable(false);
            text = _this.getTextFromInsistentDialog( "Titulo deste Postit", text );

            this.getElement('.postit-title').set('text', text.trim() );
            postit.makeEditable(true);
        });

        if ( !postit.getTitle() ) {
            postit.getDragElement().fireEvent('dblclick');
        }

        // Poe o foco no conteudo
        element.fireEvent('mouseup');
    },

    getTextFromInsistentDialog: function( title, text, only_empty_text ) {
        if ( $type(text) != 'string' || text.match(/^\s*$/) || !only_empty_text ) {
            var temp_text = prompt( title, text );
            text = this.getTextFromInsistentDialog( title, ( temp_text == null ? text : temp_text ), true );
        }

        return text;
    }
});
