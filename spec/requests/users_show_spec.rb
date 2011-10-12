require "spec_helper"

describe "User show" do

  it "renders users#show" do
    user = users(:user01)
    get "/#{user.to_param}"
    response.should render_template('users/show')
  end
end