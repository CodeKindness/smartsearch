// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
//= require 'application/summernote.min'
//= require 'application/jquery.autosize.min'
//= require 'application/bootstrap-editable.min'

$(function() {
  $('#wysiwyg_compose').summernote({
    height: 300
  });

  yukon_textarea_autosize.init();

  $.fn.editable.defaults.ajaxOptions = {type: "PUT", dataType: 'json'};
  $.fn.editable.defaults.mode = 'inline';

  $('.editable').editable({
    url: '/messages/ajax_update_company'
  });
});
