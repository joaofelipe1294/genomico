function remove_line(event){
  event.preventDefault()
  let line_to_remove = event.target.parentNode.parentNode
  let index_to_remove = parseInt($(line_to_remove).find('.index').text())
  let current_exams = $('#exam_ids').val()
  current_exams = JSON.parse(current_exams)
  delete current_exams[index_to_remove]
  current_exams = current_exams.filter(Boolean);
  line_to_remove.remove()
  $('#exam_ids').val(JSON.stringify(current_exams))
  document.querySelectorAll('.index').forEach((element, index) => $(element).text(index))
}

function add_line (offered_exam = {}) {
  let current_index = $('.id').length
  $('#exams_table').append(`
      <tr>
        <td>${offered_exam.name}</td>
        <td>${offered_exam.field}</td>
        <td class="id" hidden>${offered_exam.id}</td>
        <td class="index" hidden>${current_index}</td>
        <td>
          <button class="btn btn-sm btn-outline-danger" onclick="remove_line(event)">
            Remover
          </button>
        </td>
      </tr>`)
}

$(document).on('turbolinks:load', () => {
  if ($('#new-attendance-form').length > 0){
    $('#fields_select option:eq(0)').prop('selected', true)
    let lines = $('#exams_table').find('tr')
    if (lines.length === 0)
      $('#exam_ids').val('')

    $('#btn_add_exam').click(event => {
      event.preventDefault()
      let field = $('#fields_select option:selected').text().trim()
      let exam_name = $('#exams_select option:selected').text().trim()
      let exam_id = $('#exams_select').val()
      let current_value = $('#exam_ids').val()
      let exam = {
        offered_exam_id: exam_id
      }
      if (current_value.length === 0){
        $('#exam_ids').val(JSON.stringify([exam]))
        add_line({name: exam_name, field: field, id: exam_id})
      }else{
        current_value = JSON.parse(current_value)
        current_value.push(exam)
        $('#exam_ids').val(JSON.stringify(current_value))
        add_line({name: exam_name, field: field, id: exam_id})
      }
    })

    $('#fields_select').change(() => {
      let field_id = $('#fields_select').val()
      $.ajax({
        url: `/offered_exams?field=${field_id}`,
        dataType: 'json',
        success: response => {
          $('#exams_select').find("option").remove()
            response.forEach(exam => {
              $('#exams_select').append(`
                  <option value = ${exam.id}>
                    ${exam.name}
                  </option>`)
            })
        },
        error: error => {
          console.log(error)
          alert('Houve um erro no servidor, tente novamente mais tarde')
        }
      })
    })
  }
});
