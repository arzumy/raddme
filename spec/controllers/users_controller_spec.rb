require "spec_helper"

describe UsersController do
  describe "GET show" do
    context 'user exists' do
      it "shows user's page'" do
        user = users(:user01)
        get :show, id: user.to_param
        response.should render_template :show
      end
    end

    context 'user not found' do
      it "redirects to root path" do
        get :show, id: 'not-a-user'
        response.code.should redirect_to root_path
      end
    end
  end

  describe "GET edit" do
    before do
      @user = users(:user01)
    end

    context 'user logged in' do
      it 'display edit form' do
        sign_in @user
        get :edit, id: @user.to_param
        response.should render_template :edit
      end
    end

    context 'user not logged in' do
      it 'redirects to root path' do
        get :edit, id: @user.to_param
        response.should redirect_to new_user_session_path
      end
    end
  end

  describe "PUT update" do
    context 'user update details' do
      it 'marks user as not new' do
        user = users(:user00)
        sign_in user
        put :update, id: user.to_param, user: {fullname: 'This is fullname', password: 'password', password_confirmation: 'password'}
        response.should redirect_to public_user_path(user)
        user.reload.registered?.should be_true
      end
    end
  end
end