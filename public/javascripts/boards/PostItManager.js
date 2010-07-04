var PostItManager = new Class({
    helper            : null,
    postitCollection  : null,
    container         : null,
    documentName      : null,
    revision          : null,
    background        : document.body,

    initialize: function( param ) {
        this.container        = document.body;
        this.postitCollection = new Array();
        this.history          = new Array();
        this.documentName     = param.documentName;
        this.background       = param.background;

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

        this.background.setStyle('background-image',  json.background.image  );
        this.background.setStyle('background-repeat', json.background.repeat );

        var postit_in_uri = $pick( new String(window.location).match(/#(postit-\d+)$/), [] )[1];

        if ( postit_in_uri ) {
          $(postit_in_uri).fireEvent('click').fireEvent('mouseup');
        }

        return this;
    },

    getDocumentName: function() {
        return this.documentName;
    }
});

