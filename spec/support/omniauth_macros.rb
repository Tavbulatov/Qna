# frozen_string_literal: true

module OmniauthMacros
  def mock_auth_hash_vkontakte
    OmniAuth.config.mock_auth[:vkontakte] = OmniAuth::AuthHash.new({ provider: 'vkontakte',
                                                                     uid: '123123',
                                                                     info: {
                                                                       name: 'Test User'
                                                                     } })
  end

  def mock_auth_hash_github
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({ provider: 'github',
                                                                  uid: '123456',
                                                                  info: {
                                                                    email: 'test@example.com',
                                                                    name: 'Test User'
                                                                  } })
  end
end
