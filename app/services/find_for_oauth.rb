# module Services
  class FindForOauth
    attr_reader :auth

    def initialize(auth)
      @auth = auth
    end

    def call
      authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
      return authorization.user if authorization

      return nil unless auth.info&.email

      email = auth.info[:email]
      name = auth.info&.name&.split()
      user = User.where(email: email).first

      if user
        user.create_authorization(auth)
      else
        password = Devise.friendly_token[0, 20]
        user = User.create!(last_name: name.first, first_name: name.last,
                            email: email, password: password, password_confirmation: password)
        user&.create_authorization(auth)
      end

      user
    end
  end
# end
