var Menu = new Class({
    Implements: Options,
    options: {
        menu_element: null
    },
    initialize: function(menu_element) {
        if ($type(menu_element) != Element) menu_element = $(menu_element);
        this.setOptions({menu_element: menu_element });
        this.removeFocusFromLinks();
    },
    removeFocusFromLinks: function() {
        this.options.menu_element
        .getElements('a').addEvent('click', function() {
            this.blur();
        });
    }
});

var ActionMenu = new Class({
    Extends: Menu,
    initialize: function(menu_element) {
        if ($type(menu_element) != Element) menu_element = $(menu_element);
        this.setOptions({menu_element: menu_element });

        this.makeHiddable();
        this.show();
        this.hide.delay(5000, this);
    },
    makeHiddable: function() {
        var menu_element = this.options.menu_element;
        var _this = this;

        menu_element
        .set('morph', {duration: 'long', transition: 'elastic:out'})
        .store('original-size', menu_element.getStyle('height') )
        .store('hidden', true)
        .setStyle('height', 8)
        .addEvent('mouseover', function() { _this.show() })
        .addEvent('mouseout', function() { _this.hide() })
        .addEvent('click', function(e) {
            if (e && !(e.target == this || this.getElement('.toggle') == e.target)) return;
            _this.toggle();
        });
    },
    isHidden: function() {
        return this.options.menu_element.retrieve('hidden');
    },
    toggle: function() {
        if ( this.isHidden() ) this.show();
        else this.hide();
    },
    show: function() {
        if (!this.isHidden()) return;
        this.options.menu_element.morph({height: this.options.menu_element.retrieve('original-size') });
        this.options.menu_element.store('hidden', false);
    },
    hide: function() {
        if (this.isHidden()) return;
        this.options.menu_element.morph({height: 8});
        this.options.menu_element.store('hidden', true);
    }
});

window.addEvent('domready', function() {
    var menu = new Menu('topo');
    var menu = new ActionMenu('page-slice');
});
