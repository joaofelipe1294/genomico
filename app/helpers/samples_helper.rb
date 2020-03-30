module SamplesHelper

  def sample_options_helper sample
    @sample = sample
    options = ""
    options << extract_subsample_link
    options << sample_internal_code_link
    options << edit_sample_link
    options << remove_sample_link
    options.html_safe
  end

  private

    def extract_subsample_link
      link = ""
      if session[:field_id] != Field.IMUNOFENO.id
        link = link_to(
          'Extrair subamostra',
          new_subsample_path(sample: @sample.id),
          class: 'btn btn-sm btn-outline-primary new-subsample ml-3')
      end
      link
    end

    def sample_internal_code_link
      link = ""
      if session[:field_id] == Field.IMUNOFENO.id
        link = link_to(
          'Código interno',
          internal_codes_path({sample: @sample, target: "sample", attendance: params[:id]}),
          method: :post,
          class: 'btn btn-sm btn-outline-secondary new-internal-code ml-3')
      end
      link
    end

    def edit_sample_link
      link_to('Editar', edit_sample_path(@sample), class: 'btn btn-sm btn-outline-warning ml-3 edit-sample')
    end

    def remove_sample_link
      link = ""
      if @sample.internal_codes.size == 0 && @sample.subsamples.size == 0
        link = link_to(
          'Remover',
          sample_path(@sample),
          data: { confirm: "Tem certeza ?" },
          class: 'btn btn-sm btn-outline-danger remove-sample ml-3',
          method: :delete)
      end
      link
    end

end
