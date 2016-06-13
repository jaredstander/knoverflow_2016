require 'rails_helper'
 
describe User do
  before :each do
    @user = build(:user)
  end

  describe "#new" do
    it "takes 4 parameters and returns a user obejct" do
      expect(@user).to be_valid
    end
  end

  describe "#name" do
    it "requires a name" do
      expect(@name).to validates_presence_of(:name)
    end

    it "returns the correct name" do
      expect(@user.name).to eql "Artorias"
    end
  end

  describe "#email" do
    it "returns the correct email" do
      expect(@user.email).to eql "artorias@abysswalker.net"
    end
  end

end