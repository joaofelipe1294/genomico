module SubsamplesHelper

  def subsamples_options_helper subsample
    options = ""
    if User.find(session[:user_id]).fields.first != Field.IMUNOFENO && subsample.internal_codes.empty?
      options << link_to("Código interno", new_internal_code_path(subsample, target: "subsample"), method: :post, class: 'btn btn-sm btn-outline-secondary new-internal-code ml-3')
    end
    options << link_to('Editar', edit_subsample_path(subsample), class: 'btn btn-sm btn-outline-warning edit-subsample ml-3')
    options.html_safe
  end

end
