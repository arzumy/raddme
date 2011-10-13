require 'spec_helper'

describe User do
  describe "#friends" do
    it "returns users who are friends" do
      user01 = users(:user01)
      user01.friends.should == [users(:user02)]
    end
  end

  describe "#friend_ids" do
    context "no friends" do
      it "returns empty array" do
        users(:user00).friend_ids.should be_empty
      end
    end
    
    context "with one friend" do
      it "returns array of user id" do
        users(:user01).friend_ids.should == [users(:user02).id]
      end
    end
  end
end