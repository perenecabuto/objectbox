var PostItManager = new Class({
    helper            : null,
    postitCollection  : null,
    container         : null,
    documentName      : null,
    revision          : null,

    initialize: function( param ) {
        this.container        = document.body;
        this.postitCollection = new Array();
        this.history          = new Array();
        this.documentName     = param.documentName;

        if ( PostItHelper ) {
            this.helper = new PostItHelper();
        }

        if ( param && param.container ) {
            this.container = param.container;
        }
    },

    newPostIt: function( param ) {
        if ( $type(param) != 'object' ) {
            param = {};
        }

        if ( !param.container ) {
            param.container = this.container;
        }

        var postit = new PostIt( param );

        this.postitCollection.push( postit );

        return postit;
    },

    makeAllEditable: function(isEditable) {
      this.postitCollection.each(function(el) {
        el.makeEditable(isEditable);
      });
    },

    destroyAll: function(force) {
        if ( this.postitCollection.length < 1 ) {
            return;
        }

        if ( !force && !confirm("Deseja realmente destruir todas as anotacoes!?") ) {
            return false;
        }

        for ( var i = this.postitCollection.length -1; i >= 0; i-- ) {
            this.postitCollection[i].destroy();
            this.postitCollection.splice(i,1);
        };

        return this;
    },

    restore: function(json) {
        var _this = this;

        this.destroyAll(true);

        _this.revision = json._rev;

        json.elements.each( function(el) {
            this.newPostIt({
                id               : el.id,
                container        : this.container,
                title            : el.title,
                content          : el.content,
                x                : el.x,
                y                : el.y,
                width            : el.width,
                height           : el.height,
                background_color : el.background_color,
                color            : el.color
            });
        }, _this);

        this.container.setStyle('background-image',  json.background.image  );
        this.container.setStyle('background-repeat', json.background.repeat );

        return this;
    },

    getDocumentName: function() {
        return this.documentName;
    }
});

