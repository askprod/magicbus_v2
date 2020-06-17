// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require rails-ujs
//= require moment
// If you require timezone data (see moment-timezone-rails for additional file options)
//= require moment-timezone-with-data
//= require tempusdominus-bootstrap-4
//= require activestorage
//= require cocoon
//= require intlTelInput
//= require libphonenumber/utils
//= require turbolinks
//= require cookies_eu
//= require_tree .

// Petite croix pour cacher fênetres AJAX de connection/inscription/edit
$(document).on("click", "#close-button", function(){
    $('#login-form').hide();
  });
  
  // Close notice/alert div
  $(document).on("click", ".close", function(){
    $('#alert').hide();
  });
  
  // Images that disappear as you scroll
  $(document).ready(function(){
    $(window).scroll(function(){
        $(".image-cover").css("opacity", 1 - $(window).scrollTop() / ($('.image-cover').height() / 1.1));
    });
  });
  
  // Fade out alert/flash partial.
  $(document).ready(function(){
    setTimeout(function(){
      $('#alert').fadeOut();
    }, 3000);
   })
  
  // Hide/Show Navbar on scroll
  $(document).ready(function () {
    'use strict';
     var c, currentScrollTop = 0,
         navbar = $('#navbar');
  
     $(window).scroll(function () {
        var a = $(window).scrollTop();
        var b = navbar.height();
       
        currentScrollTop = a;
       
        if (c < currentScrollTop && a > b + b) {
          navbar.addClass("is-hidden");
        } else if (c > currentScrollTop && !(a <= b)) {
          navbar.removeClass("is-hidden");
        }
        c = currentScrollTop;
    });
  });
  
  $(document).ready(function () {
    'use strict';
     var c, currentScrollTop = 0,
         navbar = $('.navbar-collapse');
  
     $(window).scroll(function () {
        var a = $(window).scrollTop();
        var b = navbar.height();
       
        currentScrollTop = a;
       
        if (c < currentScrollTop && a > b + b) {
          navbar.removeClass("show");
        } 
        c = currentScrollTop;
    });
  });
  
  
  
  
  
  