require 'rails_helper'

describe User do
  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    it { should validate_presence_of :password_confirmation }
  end

  describe 'instance methods' do
    it 'can generate a unique api_key' do
      user1 = create(:user)
      user2 = create(:user)

      expect(user1.api_key.length).to eq(22)
      expect(user2.api_key.length).to eq(22)
      expect(user1.api_key).to_not eq(user2.api_key)
    end
    it 'can return a status' do
      user = create(:user)
      expect(user.status).to eq(201)
    end
  end
end
