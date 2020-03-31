module ApplicationHelper

  def bedge value, kind
    return %Q(<span class="badge mr-1 badge-#{kind}">#{value}</span>).html_safe if value > 0
  end

  def span params
    if params[:condition]
      color = :success
    else
      color = :secondary
    end
    %Q(<span class="text-#{color}">#{params[:text]}</span>).html_safe
  end

  def show_errors model
    if model.errors.any?
      messages = model.errors.full_messages.map { |message| "<li class='error'>#{message}</li>" }
      %Q(
        <div id="error_explanation">
          <ul>
            #{messages.join("")}
          </ul>
        </div>
      ).html_safe
    end
  end

end
