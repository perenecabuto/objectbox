
PostItManager.implement({
    history           : null,
    historyIndex      : 0,

    newPostIt: function( param ) {
        if ( $type(param) != 'object' ) {
            param = {};
        }

        if ( !param.container ) {
            param.container = this.container;
        }

        var postit = new PostIt( param );

        this.helper.animate( postit );
        this.postitCollection.push( postit );

        return postit;
    },

    save: function(url) {
        var json = {
            title    : this.getDocumentName(),
            elements : [],
            background : {
                image  : this.container.getStyle('background-image'),
                repeat : this.container.getStyle('background-repeat')
            }
        };

        if ( this.revision ) {
            json._rev = this.revision;
        }

        for ( var i = this.postitCollection.length -1; i >= 0; i-- ) {
            var postit = this.postitCollection[i];

            json.elements.push({
                id              : postit.getId(),
                title           : postit.getTitle(),
                content         : postit.getContent(),
                x               : postit.element.getStyle('left').toInt(),
                y               : postit.element.getStyle('top').toInt(),
                width           : postit.element.getStyle('width'),
                height          : postit.element.getStyle('height'),
                background_color: postit.element.getStyle('background-color'),
                color           : postit.element.getStyle('color')
            });
        };

        var _this = this;

        new Request.JSON({
            headers   : { "Content-Type" : "application/json" },
            url       : url,
            data      : json,
            onComplete: function( response ) {
                if ( response ) {
                    _this.revision = response.rev;
                }
            }
        }).post(json);

        this.history.push( JSON.encode( json ) );

        return this;
    },

    changeHistory: function(steps) {
        var tmpHistoryIndex = this.historyIndex + steps;

        if ( tmpHistoryIndex < 0 || tmpHistoryIndex >= this.history.length ) {
            return false;
        }

        this.destroyAll(true);
        this.historyIndex = tmpHistoryIndex;

        var json = JSON.decode( this.history[this.historyIndex] );

        json.elements.each( function(el) {
            this.newPostIt({
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
        }, this);

        this.container.setStyle('background-image',  json.background.image  );
        this.container.setStyle('background-repeat', json.background.repeat );

        return this;
    },

    redo: function() {
        this.changeHistory(+1);
        return this;
    },

    undo: function() {
        this.changeHistory(-1);
        return this;
    },

    setDocumentName: function(name) {
        this.documentName = name;
        return this;
    },

    getDocumentName: function() {
        return this.documentName;
    }
});
