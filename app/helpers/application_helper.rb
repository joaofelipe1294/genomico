module ApplicationHelper

  def bedge value, kind
    return %Q(<span class="badge mr-1 badge-#{kind}">#{value}</span>).html_safe if value > 0
  end

end
