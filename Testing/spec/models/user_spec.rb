require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:toby){User.create(
    username: "Toby",
    password: "password"
  )}

  describe "uniqueness" do
    before :each do
      create(:user)
    end

    it{ should validate_uniqueness_of(:username)}
    it{ should validate_uniqueness_of(:session_token)}
  end
end
