function switch_to_attendance(){
  $('#attendance_nav').removeClass('active');
  $('#exams_nav').removeClass('active');
  $('#samples_nav').removeClass('active');
  $('#attendance_tab').css('display', 'none');
  $('#exams_tab').css('display', 'none');
  $('#samples_tab').css('display', 'none');
  $('#attendance_nav').addClass('active');
  $('#attendance_tab').fadeToggle();
}

function switch_to_exams(){
  $('#attendance_nav').removeClass('active');
  $('#exams_nav').removeClass('active');
  $('#samples_nav').removeClass('active');
  $('#attendance_tab').css('display', 'none');
  $('#exams_tab').css('display', 'none');
  $('#samples_tab').css('display', 'none');
  $('#exams_nav').addClass('active');
  $('#exams_tab').fadeToggle();
}

function switch_to_samples(){
  $('#attendance_nav').removeClass('active');
  $('#exams_nav').removeClass('active');
  $('#samples_nav').removeClass('active');
  $('#attendance_tab').css('display', 'none');
  $('#exams_tab').css('display', 'none');
  $('#samples_tab').css('display', 'none');
  $('#samples_nav').addClass('active');
  $('#samples_tab').fadeToggle();
}

$(document).on('turbolinks:load', () => {
  if ($('#new-attendance-form').length > 0){
    $('#attendance_nav').click((event) => {
      event.preventDefault();
      switch_to_attendance();
    });

    $('#exams_nav').click((event) => {
      event.preventDefault();
      switch_to_exams();
    });

    $('#samples_nav').click((event) => {
      event.preventDefault();
      switch_to_samples();
    });
  }
})
