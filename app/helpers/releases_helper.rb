module ReleasesHelper

  def display_release_message user_id
    release_check = User.find(user_id)
                                      .release_checks
                                      .where(has_confirmed: false)
                                      .order(created_at: :asc)
                                      .first
    message = "Disponibilizada nova versão #{release_check.release.tag}. "
    message << "#{release_check.release.message}"
    message << link_to('Ok', release_path(release_check.release, {release_check: release_check}), method: :patch, class: "float-right btn btn-outline-success", id: "confirm-release").html_safe
    message.html_safe
  end

end
