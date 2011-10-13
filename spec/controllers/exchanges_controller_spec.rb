require "spec_helper"

describe ExchangesController do
  describe "GET show" do
    context "invite token exists" do
      it 'redirects to edit user' do
        user = users(:user00)
        get :show, token: user.invite_token
        response.should redirect_to edit_user_path(user)
      end
    end

    context "invite token doesn't exist" do
      it 'redirects to root' do
        get :show, token: 'this-token-doesnt-exist'
        response.should redirect_to root_path
      end
    end
  end
end
