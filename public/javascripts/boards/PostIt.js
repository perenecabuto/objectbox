
var PostIt = new Class({
    flipImage: '/images/flip.png',
    element  : null,
    container: null,
    id       : null,

    color_functions: [
        new Element('span', { styles: {background: '#484848', color:'white'} }),
        new Element('span', { styles: {background: 'white', color:'black'} }),
        new Element('span', { styles: {background: '#ddd' , color:'black'} }),
        new Element('span', { styles: {background: '#66f' , color:'white'} }),
        new Element('span', { styles: {background: '#f44' , color:'white'} }),
        new Element('span', { styles: {background: '#6f6' , color:'black'} }),
        new Element('span', { styles: {background: '#ff6' , color:'black'} })
    ],

    initialize: function( param ) {
        this.container = document.body;
        this.id = param.id;

        if ( param && param.container ) {
            this.container = param.container;
        }

        this.buildVisualization( param );
        this.makeEditable( false );
    },

    buildVisualization: function( param ) {
        if ( $type(param) != 'object' ) {
            param = {};
        }

        this.element  = new Element('fieldset', { 'class':'postit', 'id': 'postit-' + this.getId() }).inject(this.container);
        var flip      = new Element('img', { 'class':'resize', 'src': this.getFlipImage()}).inject(this.element);
        var functions = new Element('div', { 'class':'postit-functions' }).inject(this.element);
        var content   = new Element('textarea', { 'class':'postit-content' }).inject(this.element);

        var delete_function_element = new Element('a',    { 'class':'postit-delete' }).inject(functions);
        var color_function_elements = new Element('div',  { 'class':'postit-color-functions' }).inject(functions);
        var title                   = new Element('span', { 'class':'postit-title', 'title':'Duplo clique para alterar o titulo' }).inject(functions);

        var postit = this;
        delete_function_element
        .set({html: "&nbsp;", href: "javascript: void(0);"})
        .addEvent("click", function() { postit.destroy() });

        // Define posicao
        this.element.setStyles({
            'z-index'          : '2',
            'left'             : ( param.x || Math.ceil(Math.random() * 700) ) + 'px',
            'top'              : ( param.y || Math.ceil(Math.random() * 200) ) + 'px',
            'width'            : param.width,
            'height'           : param.height,
            'background-color' : param.background_color || this.color_functions[0].getStyle('background-color'),
            'border-color'     : param.color || this.color_functions[0].getStyle('color'),
            'color'            : param.color || this.color_functions[0].getStyle('color')
        });

        if ( param.content ) {
            content.set('html', param.content );
        }

        // Define funcoes de cor
        this.color_functions.each( function(func) {
            var newfunc = func.clone();
            color_function_elements.adopt( newfunc );

            newfunc.addEvent('mousedown', function(e) {
                e.stop();
                this.getParent('.postit').setStyles({
                    'background-color': this.getStyle('background-color'),
                    'border-color'    : this.getStyle('color'),
                    'color'           : this.getStyle('color')
                });
            });
        });

        // Mostra caixa de edicao do titulo
        // Se ainda nao tiver titulo
        if ( param.title && !new String( param.title ).match("^\s*$") ) {
            title.set('text', param.title );
        }

        // Da foco ao soltar o botao do mouse apos o postit ter sido clicado
        this.element.addEvent('mousedown', function() {
            content.focus();
        });

        return this;
    },

    makeEditable: function( isEditable ) {
        this.getElement('textarea').set('readonly', !isEditable);
        return this;
    },

    setId: function(id) {
      this.id = id;
    },
    getId: function() {
      return this.id;
    },

    getTitle: function() {
        return this.getElement('.postit-title').get('text');
    },

    getContent: function() {
        return this.getElement('.postit-content').get('value');
    },

    setFlipImage: function(value) {
        this.flipImage = value;
    },
    getFlipImage: function() {
        return this.flipImage;
    },

    getContainer: function() {
        return this.container;
    },

    getElement: function( path ) {
        var element = this.element;

        if ( path ){
            element = this.element.getElement( path );
        }

        return element;
    },

    getResizeElement: function() {
        return this.getElement('.resize');
    },

    getDragElement: function() {
        return this.getElement('.postit-functions');
    },

    destroy: function() {
        this.element.dispose();
    }
});

