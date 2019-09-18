module SamplesHelper

  def sample_options_helper sample
    options = ""
    if sample.sample_kind != SampleKind.LIQUOR
      options << link_to('Extrair subamostra', new_sub_sample_path(sample), class: 'btn btn-sm btn-outline-primary new-subsample ml-3')
    end
    options << link_to('Código interno', new_internal_code_path(sample, target: "sample"), method: :post, class: 'btn btn-sm btn-outline-secondary new-internal-code ml-3')
    options << link_to('Editar', edit_sample_path(sample), class: 'btn btn-sm btn-outline-warning ml-3 edit-sample')
    if sample.internal_codes.size == 0 && sample.subsamples.size == 0
      options << link_to('Remover', sample_path(sample), data: { confirm: "Tem certeza ?" }, class: 'btn btn-sm btn-outline-danger remove-sample ml-3', method: :delete)
    end
    options.html_safe
  end

end
