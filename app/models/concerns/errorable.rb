module Errorable
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
