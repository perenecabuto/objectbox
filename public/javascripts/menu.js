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
        this.toggle();
        this.toggle.delay(5000, this);
    },
    makeHiddable: function() {
        var menu_element = this.options.menu_element;
        var _this = this;

        menu_element.set('morph', {duration: 'long', transition: 'elastic:out'});
        menu_element.store('original-size', menu_element.getStyle('height') );
        menu_element.store('hidden', true);
        menu_element.setStyle('height', 8);

        menu_element.addEvent('click', function(e) {
            if (e && !(e.target == this || this.getElement('.toggle') == e.target)) return;
            if ( this.retrieve('hidden') ) {
                this.morph({height: this.retrieve('original-size') });
                this.store('hidden', false);
            } else {
                this.morph({height: 8});
                this.store('hidden', true);
            }
        });
    },
    toggle: function() {
        this.options.menu_element.fireEvent('click');
    }
});

window.addEvent('domready', function() {
    var menu = new Menu('topo');
    var menu = new ActionMenu('page-slice');
    $$('a').addEvent('click', function() { document.location = 'index.html' });
});
