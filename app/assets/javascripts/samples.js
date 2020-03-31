function remove_sample_line(event){
  event.preventDefault()
  let line = event.target.parentNode.parentNode
  let remove_index = parseInt($(line).find('.index').text())
  let samples = $('#samples').val()
  samples = JSON.parse(samples)
  delete samples[remove_index]
  samples = samples.filter(Boolean);
  line.remove()
  $('#samples').val(JSON.stringify(samples))
  document.querySelectorAll('.index').forEach((element, index) => element.textContent = index )
}

function sample_builder(){
  let sample_kind_id = $('#sample_kind').val();
  let sample_kind_name = $('#sample_kind option:selected').text();
  let collection_date = $('#collection_date_').val();
  let receipt_notice = $('#receipt_notice').val();
  let storage_location = $('#storage_location').val();
  let sample = {
    sample_kind_id,
    sample_kind_name,
    collection_date,
    receipt_notice,
    storage_location
  }
  return sample;
}

function append_sample_line(sample){
  $('#samples_table').append(`
    <tr>
      <td>${sample.sample_kind_name}</td>
      <td>${sample.collection_date}</td>
      <td>${sample.receipt_notice}</td>
      <td>${sample.storage_location}</td>
      <td class="index" hidden>${sample_index}</td>
      <td>
        <button class="btn btn-sm btn-outline-danger" onclick="remove_sample_line(event)">
          Remover
        </button>
      </td>
    </tr>
  `)
}

$(document).on('turbolinks:load', () => {
  if ($('#new-attendance-form').length > 0){
    $('#samples').val('')

    $('#btn_add_sample').click(event => {
      event.preventDefault()
      if ($('#receipt_notice').val().length === 0)
        alert('Informe o número de frascos.')
      else{
        const sample = sample_builder();
        let samples = $('#samples').val()
        const sample_index = $('.btn-outline-danger').length
        append_sample_line(sample);
        delete sample.sample_kind_name
        if (samples.length === 0){
          $('#samples').val(JSON.stringify([sample]))
        }else{
          let new_value = JSON.parse(samples)
          new_value.push(sample)
          $('#samples').val(JSON.stringify(new_value))
        }
        $('#receipt_notice').val('1 frasco')
        $('#storage_location').val('')
      }
    })
  }
});
