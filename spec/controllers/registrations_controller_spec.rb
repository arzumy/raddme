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
          post :create, user: {fullname: 'User 01', email: user.email, password: 'password', password_confirmation: 'password'}
          response.should redirect_to new_user_password_path
          flash[:notice].should match /Seems like you've registered before/
        end
      end
    end
  end
end