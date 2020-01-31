module UsersHelper

  def show_user_kind user
    if user.admin?
      color = :primary
    else
      color = :secondary
    end
    %Q(<span class="text-#{color}">#{user.kind_name}</span>).html_safe
  end

  def show_is_active is_active
    if is_active
      color = :success
      text = "Ativo"
    else
      color = :secondary
      text = "Inativo"
    end
    %Q(<span class="text-#{color}">#{text}</span>).html_safe
  end


end
