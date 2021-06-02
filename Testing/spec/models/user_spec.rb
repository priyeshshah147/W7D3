require 'rails_helper'

RSpec.describe User, type: :model do
  # subject(:toby){User.create(
  #   username: "Toby",
  #   password: "password"
  # )}

  describe "uniqueness" do
    before :each do
      User.create(
        username: "Toby",
        password: "password",
        password_digest: "abc",
        session_token: SecureRandom::urlsafe_base64
      )
    end

    it{ should validate_uniqueness_of(:username)}
    it{ should validate_uniqueness_of(:session_token)}
    it{ should validate_presence_of(:password_digest)}
  end
end
