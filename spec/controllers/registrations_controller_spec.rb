require 'spec_helper'

describe RegistrationsController do
  before do
    request.env["devise.mapping"] = Devise.mappings[:user]
  end
  
  describe 'POST create' do
    context 'user already existed' do
      describe "user hasn't reciprocate yet" do
        it 'redirects to reset password page' do
          pending "Let's not do this yet, added complexity and query"
          user = users(:user00)
          post :create, user: {fullname: 'User 00', email: user.email, password: 'password', password_confirmation: 'password'}
          response.should redirect_to new_user_password_path
          flash[:notice].should match /You should check your email/
        end
      end

      describe "user properly registered" do
        it 'redirects to reset password page' do
          user = users(:user01)
          post :create, user: {fullname: 'User 01', email: user.email, url: user.url, password: 'password', password_confirmation: 'password'}
          response.should redirect_to new_user_password_path
          flash[:notice].should match /Seems like you've registered before/
        end
      end
    end
  end

  describe 'GET edit' do
    it 'displays edit form' do
      user = users(:user01)
      sign_in user
      get :edit
      response.should render_template(:edit)
    end
  end

  describe 'POST update' do
    context 'valid details' do
      describe "edit fullname" do
        it "changes user's fullname" do
          user = users(:user01)
          sign_in user
          put :update, user: {fullname: 'new fullname'}
          assigns(:user).fullname.should_not == user.fullname
        end
      end
    end
  end
end