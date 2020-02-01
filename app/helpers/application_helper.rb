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

end
