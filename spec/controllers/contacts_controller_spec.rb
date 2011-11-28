require 'spec_helper'

describe ContactsController do
  describe "GET index" do
    before do
      @user = users(:user01)
      sign_in @user
    end

    it "assigns exchanged_count" do
      get :index
      assigns(:exchanged_count).should == @user.friends.registered.count
    end

    it "assigns pending_count" do
      get :index
      assigns(:pending_count).should == @user.friends.unregistered.count
    end
  end
end