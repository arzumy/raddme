require "spec_helper"

describe OfflineController do
  render_views

  describe "GET show" do
    it "renders content-type properly" do
      get :show
      response.headers['Content-Type'].should == 'text/cache-manifest'
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

    context "user's logged in" do
      let(:user) { users(:user01) }

      before do
        sign_in user
      end

      it "includes current user" do
        get :show
        response.body.should match(/#{user.friendly_id}/)
      end

      it "includes user's gravatar" do
        get :show
        response.body.should match(/gravatar\.com/)
      end
    end
  end
end