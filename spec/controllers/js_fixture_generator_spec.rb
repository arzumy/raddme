require 'spec_helper'

describe 'save fixtures' do
  render_views(true)

  describe UsersController do
    specify "show" do
      user = users(:user01)
      sign_in user
      get :show, id: user.to_param
      response.should be_success
      save_fixture('body','public-user')
    end
  end
end
