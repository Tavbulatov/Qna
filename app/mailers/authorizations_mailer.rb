# frozen_string_literal: true

class AuthorizationsMailer < ApplicationMailer
  def authorization_confirmation(authorization)
    @authorization = authorization
    @token = authorization.confirmation_token

    mail to: authorization.user.email
  end
end
