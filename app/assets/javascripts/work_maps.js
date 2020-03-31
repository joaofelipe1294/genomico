function remove_internal_code(event){
  event.preventDefault();
  let reference_value = $(event.target).attr('data-reference-value');
  $(`#internal-code-${reference_value}`).remove();
  let current_ids = $('#internal-code-ids').val().split(',');
  let index = current_ids.indexOf(reference_value);
  current_ids.splice(index, 1);
  let new_value = current_ids.join(',');
  $('#internal-code-ids').val(new_value);
}

function update_internal_codes_input(internal_code){
  let current_value = $('#internal-code-ids').val();
  let ids = current_value.split(',');
  if(ids.includes(internal_code.id.toString()) === false){
    ids.push(internal_code.id);
    let new_value = ids.join(',');
    $('#internal-code-ids').val(new_value);
    return true;
  }else
    return false;
}

function append_work_map_line(internal_code){
  $('#work-map-samples').append(`
     <tr id="internal-code-${internal_code.id}" class="internal-code">
       <td>${internal_code.code}</td>
       <td>${internal_code.field.name}</td>
       <td>
         <button class="btn btn-sm btn-outline-danger remove" data-reference-value="${internal_code.id}" onclick="remove_internal_code(event)">
           Remover
         </button>
       </td>
     </tr>
   `)
}

$(document).on('turbolinks:load', () => {
  if ($('#work-map-form').length > 0){
    $('#btn-search').click(event => {
      event.preventDefault()
      let code = $('#internal-code').val()
      $.ajax({
        url: `/internal_codes?code=${code}`,
        dataType: 'json',
        success: (response) => {
          let internal_code = response;
          let shoud_add_line = update_internal_codes_input(internal_code);
          if (shoud_add_line === true)
            append_work_map_line(internal_code);
          $('#internal-code').val("")
        },
        error: error => {
          if (error.status === 404)
            alert('Amostra não encontrada.');
          else
            alert('Houve um erro no servidor, tente novamente mais tarde.');
        }
      });

      $('#work-map-form').submit(() => {
        let internal_code_ids = $('#internal-code-ids').val()
        internal_code_ids = internal_code_ids.split(',')
        internal_code_ids = internal_code_ids.filter(Boolean)
        $('#internal-code-ids').val(internal_code_ids.join(','))
      })

    });
  }

});
