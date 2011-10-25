require "spec_helper"

describe OfflineController do
  render_views

  describe "GET show" do
    it "renders content-type properly" do
      pending
      get :show
      response.content_type.should == 'text/cache-manifest'
    end

    it "renders show template" do
      get :show
      response.should render_template("offline/show")
    end

    it "lists assets" do
      get :show
      response.body.should match(/bg\.png/)
      response.body.should match(/logo\.png/)
      response.body.should match(/#{Rails.application.assets.find_asset('application.css').digest_path}/)
      response.body.should match(/#{Rails.application.assets.find_asset('application.js').digest_path}/)
    end

    it "includes current user" do
      user = users(:user01)
      sign_in user
      get :show
      response.body.should match(/#{user.friendly_id}/)
    end
  end
end