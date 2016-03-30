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
//= require_tree
$(document).ready(function() {
  $("#active").on("click", function(){
    $(".active_studios").removeClass('hide')
    $(".inactive_studios").addClass('hide')
    $(".pending_studios").addClass('hide')
    $(".denied_studios").addClass('hide')
  })

  $("#inactive").on("click", function(){
    $(".inactive_studios").removeClass('hide')
    $(".active_studios").addClass('hide')
    $(".pending_studios").addClass('hide')
    $(".denied_studios").addClass('hide')
  })

  $("#pending").on("click", function(){
    $(".pending_studios").removeClass('hide')
    $(".inactive_studios").addClass('hide')
    $(".active_studios").addClass('hide')
    $(".denied_studios").addClass('hide')
  })

  $("#denied").on("click", function(){
    $(".denied_studios").removeClass('hide')
    $(".inactive_studios").addClass('hide')
    $(".active_studios").addClass('hide')
    $(".pending_studios").addClass('hide')
  })
});
