require 'spec_helper'

describe FriendshipsController do
  describe "POST create" do
    before do
      @user = users(:user01)
    end
    context "invalid email" do
      it "shows back user's page with alert" do
        post :create, user: {email: 'not valid email dude', id: @user.id}
        response.should redirect_to public_user_path(@user.to_param)
        flash[:alert].should match /invalid/
      end
    end

    context "valid email" do
      it "shows back user's page with notice" do
        post :create, user: {email: 'valid@example.com', id: @user.id}
        response.should redirect_to public_user_path(@user.to_param)
        flash[:notice].should match /shared contact/
      end
    end
  end
end