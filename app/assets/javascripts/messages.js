// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
//= require 'application/summernote.min'
//= require 'application/jquery.autosize.min'
//= require 'application/typeahead.bundle'
//= require 'application/bootstrap-editable.min'
//= require 'application/typeaheadjs'

$(function() {
  $('#wysiwyg_compose').summernote({
    height: 300
  });

  $('#message_body').on('click', function(){
    $(this).summernote({
      height: 300
    });
  });

  yukon_textarea_autosize.init();

  $.fn.editable.defaults.ajaxOptions = {type: "PUT", dataType: 'json'};
  $.fn.editable.defaults.mode = 'inline';

  // TODO: Make this work with typeahead
  //$('.editable').editable({
  //  url: '/messages/ajax_update'
  //}).on('shown', function (e, editable) {
  //  if (editable) {
  //    editable.input.$input.typeahead({
  //      source: function(query, process) {
  //        return $.get('/companies', { query: query }, function(data) { return process(data.options) });
  //      }
  //    });
  //  }
  //});

  $('.editable').editable({
    url: '/messages/ajax_update'
  });

  yukon_mailbox.init();
});
