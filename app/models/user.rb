class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, require: true
  validates_presence_of :password_confirmation, require: true
  has_secure_password
  before_create :generate_key

  def generate_key
    self.api_key = SecureRandom.urlsafe_base64
  end

  def status
    four_o_four ? 400 : 201
  end

  def four_o_four
    return pass_mismatch if pass_mismatch?
    return email_exists if email_exists?
    missing_fields if missing_fields?
  end

  private

  def pass_mismatch?
    errors.messages[:password_confirmation] == ["doesn't match Password"]
  end

  def pass_mismatch
    errors.full_messages_for(:password_confirmation).to_sentence
  end

  def email_exists?
    errors.messages[:email] == ["has already been taken"]
  end

  def email_exists
    errors.full_messages_for(:email).to_sentence
  end

  def missing_fields?
    errors.full_messages.any?
  end

  def missing_fields
    errors.full_messages.to_sentence
  end
end
