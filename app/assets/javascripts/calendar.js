// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
//= require application/fullcalendar.min
//= require application/gcal

$(function() {
  // full calendar
  if($('#calendar').length) {
    var date = new Date();
    var d = date.getDate();
    var m = date.getMonth();
    var y = date.getFullYear();

    $('#calendar').fullCalendar({
      header: {
        center: 'title',
        left: 'month,agendaWeek,agendaDay today',
        right: 'prev,next'
      },
      buttonIcons: {
        prev: 'fa fa-chevron-left',
        next: 'fa fa-chevron-right'
      },
      editable: true,
      aspectRatio: 2.2,
      events: [
        {
          title: 'All Day Event',
          start: new Date(y, m, 1)
        },
        {
          title: 'Travel',
          start: new Date(y, m, d - 5),
          end: new Date(y, m, d - 2)
        },
        {
          id: 999,
          title: 'Repeating Event',
          start: new Date(y, m, d - 3, 16, 0)
        },
        {
          id: 999,
          title: 'Repeating Event',
          start: new Date(y, m, d + 4, 16, 0)
        },
        {
          title: 'Interview',
          url: '/interviews/398hd93x03ij30ejx39jx',
          start:  new Date(y, m, d + 1, 19, 0),
          end:  new Date(y, m, d + 1, 22, 30)
        },
        {
          title: 'Lunch',
          start: new Date(y, m, d - 7)
        },
        {
          title: 'Birthday Party',
          start: new Date(y, m, d + 10)
        },
        {
          title: 'Click for Google',
          url: 'http://google.com/',
          start: new Date(y, m, d + 12)
        }
      ],
      eventAfterAllRender: function() {
        $('.fc-header .fc-button-prev').html('<i class="fa fa-chevron-left"></i>');
        $('.fc-header .fc-button-next').html('<i class="fa fa-chevron-right"></i>');
      }
    });
  }
});
