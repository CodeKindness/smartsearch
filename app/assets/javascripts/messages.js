// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
//= require 'application/summernote.min'
//= require 'application/jquery.autosize.min'

$(function() {
  $('#wysiwyg_compose').summernote({
    height: 300
  });

  yukon_textarea_autosize.init();
});
