// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs

//= require bootstrap-sprockets
//= require social-share-button
//= require_tree .

$(document).ready(function() {
  $('.search-bar').hide();
  $('.blog-dropdown').hide();

  $('#search').click(function() {
    $('.search-bar').slideToggle();
  });

  $('#blog-menu').mouseenter(function() {
    $('.blog-dropdown').fadeIn();
    return false;
  });

  $('#blog-menu').mouseleave(function() {
    $('.blog-dropdown').fadeOut();
    return false;
  });

  $('.fav-icon').hover(function(){
    $('.fav-icon').addClass('.pink');
    $('.fav-icon').removeClass('.pink');
  });
});
  
