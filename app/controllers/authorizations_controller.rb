# frozen_string_literal: true

class AuthorizationsController < ApplicationController
  def create
    password = Devise.friendly_token
    email =  params[:email]
    uid = params[:uid]
    provider = params[:provider]

    user = User.find_by(email: email) || User.create!(
      last_name: 'LastName',
      first_name: 'FirstName',
      email: email,
      password: password,
      password_confirmation: password
    )

    authorization = Authorization.find_by(provider: provider,
                                          uid: uid) ||
                    user.create_authorization(OmniAuth::AuthHash.new(
                                                provider: provider, uid: uid,
                                                confirmation_token: Devise.friendly_token
                                              ))

    AuthorizationsMailer.authorization_confirmation(authorization).deliver_later

    redirect_to root_path, notice: 'Click on the link in the email to confirm authorization'
  end

  def confirmation
    authorization = Authorization.find_by(confirmation_token: params[:confirmation_token])

    authorization.confirm!
    flash[:alert] = 'You have confirmed your authorization'
    sign_in authorization.user

    redirect_to root_path
  end
end
