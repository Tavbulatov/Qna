# frozen_string_literal: true

class DailyDigest
  def send_digest
    User.find_each(batch_size: 1000) do |user|
      DailyDigestMailer.digest(user).deliver_later
    end
  end
end
