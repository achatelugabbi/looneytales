$(document).ready(function() {
  var $container = $('#disp-area');
  $container.imagesLoaded(function(){
    $container.masonry({
      itemSelector: '.disp-unit'
    });
   });
});
