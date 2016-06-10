require 'rails_helper'
 
describe User do
  before :each do
    @user = User.new
    @user.name = "Artorias"
    @user.email = "artorias@abysswalker.net"
  end

  describe "#new" do
    it "takes 2 parameters and returns a user object" do
      expect(@user).to be_an_instance_of User
    end
  end

  describe "#name" do
    it "returns the correct name" do
      expect(@user.name).to eql "Artorias"
    end
  end

  describe "#email" do
    it "returns the correct email" do
      expect(@user.email).to eql "artorias@abysswalker.net"
    end
  end

  describe "#save" do
    it "saves the user" do
      expect { 
        post :create, :user => {:user => :attributes }
      }.to change { User.count }
    end
  end
end