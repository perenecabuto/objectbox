window.addEvent('domready', function() {
  $('new-document').addEvent('click', function() {
      var title;

      do {
          title = prompt("Informe o nome do documento");

          if ( title == null ) {
              return false;
          }
      } while( new String( title ).match('^\s*$') );

      this.getElement('a').href += "?board[title]=" + title;
  });
});
