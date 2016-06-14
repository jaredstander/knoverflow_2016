require 'rails_helper'
 
describe User do
  before :each do
    @user = build(:user)
  end

  it { should have_secure_password }

  describe "#new" do
    it "takes 4 parameters and returns a user obejct" do
      expect(@user).to be_valid
    end
  end

  describe "#name" do
    it { should validate_presence_of(:name) }
    it "returns the correct name" do
      expect(@user.name).to eql "Artorias"
    end
  end

  describe "#email" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it "returns the correct email" do
      expect(@user.email).to eql "artorias@abysswalker.net"
    end
  end

  describe "#password" do
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:password_confirmation) }
    it { should validate_confirmation_of(:password) }
    it "returns the correct email" do
      expect(@user.email).to eql "artorias@abysswalker.net"
    end
  end

end