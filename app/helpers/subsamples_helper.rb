module SubsamplesHelper

  def subsamples_options_helper subsample
    options = ""
    options << add_internal_code_to_subsample(subsample)
    options << add_edit_link(subsample)
    options << add_remove_link(subsample)
    options.html_safe
  end

  private

    def add_edit_link subsample
      if subsample.attendance.attendance_status_kind != AttendanceStatusKind.COMPLETE
        link_to(
          'Editar',
          edit_subsample_path(subsample),
          class: 'btn btn-sm btn-outline-warning edit-subsample ml-3')
      else
        ""
      end
    end

    def add_internal_code_to_subsample subsample
      if User.find(session[:user_id]).fields.first != Field.IMUNOFENO && subsample.internal_codes.empty?
        link_to(
          "Código interno",
          new_internal_code_path(subsample, target: "subsample"),
          method: :post,
          class: 'btn btn-sm btn-outline-secondary new-internal-code ml-3')
      else
        ""
      end
    end

    def add_remove_link subsample
      if subsample.internal_codes.empty?
        link_to(
          'Remover',
          subsample_path(subsample),
          data: { confirm: "Tem certeza ?" },
          method: :delete,
          class: 'btn btn-sm btn-outline-danger remove-subsample ml-3')
      else
        ""
      end
    end

end
