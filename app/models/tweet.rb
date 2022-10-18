class Tweet < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true

  validates :message, presence: true, length: {maximum: 140}

  private

    def generate_session_token
      self.token = SecureRandom.urlsafe_base64
    end
end
