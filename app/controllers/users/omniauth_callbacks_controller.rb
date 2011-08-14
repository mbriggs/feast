class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_apps
    user = User.find_or_create_by_token(env['omniauth.auth'])
    sign_in_and_redirect(user, :event => :authentication)
  end
end
