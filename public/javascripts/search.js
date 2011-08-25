function resultDynamicMaxHeight() {
  $('result').setStyle('max-height',
    window.getCoordinates().height - $('result').getCoordinates().top - 10
  );
}
window.addEvent('domready', function() {
  resultDynamicMaxHeight();

  if ( $('result').getElements('li').length == 0 ) {
    $('result').setStyle('display', 'none');
    $('result-background').setStyle('display', 'block');
    $('q').removeClass('active');
  } else {
    $('result').setStyle('display', 'block');
    $('result-background').setStyle('display', 'none');
    $('q').addClass('active');
  }

}).addEvent('resize', function() {
  resultDynamicMaxHeight();
});

