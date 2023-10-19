# frozen_string_literal: true

class OauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :set_user

  def github
    if @user&.persisted?
      authentication_user
    else
      redirect_to root_path, notice: 'Something went wrong'
    end
  end

  def vkontakte
    auth = request.env['omniauth.auth']

    if @user&.authorizations&.find_by(provider: auth.provider, uid: auth.uid.to_s)&.confirmed?
      authentication_user
    else
      redirect_to new_authorization_path(provider: auth.provider, uid: auth.uid.to_s),
                  notice: 'Enter your email for authorization and further confirmation of authorization'
    end
  end

  private

  def set_user
    @user = User.find_for_oauth(request.env['omniauth.auth'])
  end

  def authentication_user
    sign_in_and_redirect @user, event: :authentication
    set_flash_message(:notice, :success, kind: action_name.capitalize) if is_navigational_format?
  end
end
