class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :exam_status_color_helper

  def admin_filter
      user = User.find_by({
        id: session[:user_id],
        login: session[:user_login],
        user_kind: UserKind.ADMIN,
        is_active: true
      })
      if user.nil?
        reset_session
        flash[:warning] = 'Credenciais inválidas.'
        redirect_to root_path
      end
    end

    def user_filter
      user = User.find_by({
        id: session[:user_id],
        login: session[:user_login],
        user_kind: UserKind.USER,
        is_active: true
      })
      if user.nil?
        reset_session
        flash[:warning] = 'Credenciais inválidas.'
        redirect_to root_path
      end
    end

    def generic_filter
      user = User.find_by({
        id: session[:user_id],
        login: session[:user_login],
      })
      if user.nil?
        reset_session
        flash[:warning] = 'Credenciais inválidas.'
        redirect_to root_path
      end
    end

    def redirect_to_home
      if User.find(session[:user_id]).user_kind == UserKind.ADMIN
        redirect_to home_admin_index_path
      else
        redirect_to home_user_index_path
      end
    end

    def exam_status_color_helper exam_status_kind # TODO: mover para application controller e utilizar nas demais views
      color = ""
      if exam_status_kind == ExamStatusKind.find_by({name: 'Aguardando início'})
        color = "dark"
      elsif exam_status_kind == ExamStatusKind.find_by({name: 'Em andamento'})
        color = "primary"
      elsif exam_status_kind == ExamStatusKind.find_by({name: 'Liberado técnico'})
        color = "info"
      elsif exam_status_kind == ExamStatusKind.find_by({name: 'Em repetição'})
        color = "warning"
      else
        color = "success"
      end
      "<label class='text-#{color}'>#{exam_status_kind.name}</label>".html_safe
    end

end
