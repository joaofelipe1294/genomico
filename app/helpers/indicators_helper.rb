module IndicatorsHelper

  def header
    if params[:start_date].present? && params[:end_date].present?
      start_date = Date.parse params[:start_date]
    end_date = Date.parse params[:end_date]
      %Q(
        <span class="h3">
          (de #{I18n.l start_date} até #{I18n.l end_date})
        </span>).html_safe
    end
  end

end
