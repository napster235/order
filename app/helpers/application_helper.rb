module ApplicationHelper
  def redirect_if_not_logged
    controller.redirect_to new_user_session_path
  end
end
